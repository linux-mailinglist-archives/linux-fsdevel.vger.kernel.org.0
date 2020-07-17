Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640312241D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgGQRbq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:31:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58088 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbgGQRbq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595007104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oc+tQb+orRG6mlum1B7MxPOO3O8qhEIhLyg7hJEBoCA=;
        b=got76lTM5RQs/wEnLL1+TiUi3Bu26PjpHTw6U8cPWEc3A7aPqW3uQ9WAvN+rw2s35KZxKa
        yWNAbC1eTbCd0Srhc/w0pWecoFY82SA5BzEgjL6xWAqqRwAR4KQeBA/sU8mJkGTSxoOKvj
        8xYWggJqFwbiN3ttuw030SkkyDC2pSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-tbWeKkqUOnmvZ5uzugHaEQ-1; Fri, 17 Jul 2020 13:31:42 -0400
X-MC-Unique: tbWeKkqUOnmvZ5uzugHaEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAB641005268;
        Fri, 17 Jul 2020 17:31:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E35A74F64;
        Fri, 17 Jul 2020 17:31:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200713101222.GA246269@mwanda>
References: <20200713101222.GA246269@mwanda>
To:     dan.carpenter@oracle.com
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] fsinfo: Allow fsinfo() to look up a mount object by ID
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3762612.1595007100.1@warthog.procyon.org.uk>
Date:   Fri, 17 Jul 2020 18:31:40 +0100
Message-ID: <3762613.1595007100@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

<dan.carpenter@oracle.com> wrote:

>    604          ret = kstrtoul(name, 0, &mnt_id);

Hmmm...  I'm a bit surprised there isn't a warning generated: kstrtoul() takes
a pointer to an unsigned long, not a long.  mnt_id should be an unsigned
long.  I'll fix that.

>    607          if (mnt_id > INT_MAX)
>                     ^^^^^^^^^^^^^^^^
> This can be negative.  Why do we need to check this at all?  Can we just
> delete this check?

As we get a long, it can go out of range for the mount parameter we're
checking - which is an int.  I feel it's better to restrict it so that we
don't get a false match due to implicit masking.

I wonder if struct mount::mnt_id should actually be unsigned int rather than
int - there doesn't seem any reason it should go negative.

David

