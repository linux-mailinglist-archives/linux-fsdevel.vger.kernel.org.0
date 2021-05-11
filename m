Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727A637A6E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 14:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhEKMkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 08:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231597AbhEKMkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 08:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620736740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zW6HUKRjjKXm3BzeFVZwuZiMWKgwFf7ZJEWk02EXC4s=;
        b=TRCp+u+0/ics15fGtTlgSLue6ao8rsh3AcHMQtXX6V8gkuN7ioJOxzMi1GPbyWpEW+vrJa
        hkTytSv68QTzYmxGJlEtC/nyAD1HrCfMfj0aH0COBmP/DEi960xsiLf1GWe6SeJKpCEsWx
        PhzxQQjLNvUtz1K8JrU95prldRjz7Vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-gf5mG4uKNTmLPnWz5j-qrA-1; Tue, 11 May 2021 08:38:58 -0400
X-MC-Unique: gf5mG4uKNTmLPnWz5j-qrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7FE61854E21;
        Tue, 11 May 2021 12:38:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30E23101F501;
        Tue, 11 May 2021 12:38:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87czu45gcs.fsf@suse.de>
References: <87czu45gcs.fsf@suse.de>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     dhowells@redhat.com, Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: 9p: fscache duplicate cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2507721.1620736734.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 11 May 2021 13:38:54 +0100
Message-ID: <2507722.1620736734@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Luis,

> I've been seeing fscache complaining about duplicate cookies in 9p:
> =

>  FS-Cache: Duplicate cookie detected
>  FS-Cache: O-cookie c=3D00000000ba929e80 [p=3D000000002e706df1 fl=3D226 =
nc=3D0 na=3D1]

This cookie is marked acquired (fl=3D2xx), but not relinquished (fl=3D4xx)=
, so it
would still seem to be active:-/.  Pretty much one of the first things
__fscache_relinquish_cookie() does is to set that bit (should be bit 10).

One thing that might be useful is if you can turn on a couple of fscache
tracepoints:

echo 1 >/sys/kernel/debug/tracing/events/fscache/fscache_acquire/enable
echo 1 >/sys/kernel/debug/tracing/events/fscache/fscache_relinquish/enable

The cookie pointers in the duplicate cookie report should match the entrie=
s in
the trace output.

Note that my fscache-iter branch[1] improves the situation where the disk =
I/O
required to effect the destruction of a cache object delays the completion=
 of
relinquishment by inserting waits, but that oughtn't to help here.

David

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/=
log/?h=3Dfscache-iter

