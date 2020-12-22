Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0C2E0D58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 17:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgLVQ0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 11:26:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727995AbgLVQ0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608654316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VS6Vdqur46sIrPZ2F0w/ptGx4OB9WKm/fQfIUku24Qg=;
        b=MQCUjAkzdYrMtMBQ+2EZRZle14RXH8vr6D8WGxOfHCxOUcU9DAouULLPs+Dc1YaqqzICH3
        QUFKXv9EUEnK6H2PINAgtSIPodP0Ha1P+w4uP5fpLdnd2WZunz7C0kiwfy1gu4gAldMrQQ
        AElOu4Pbk6MDBqTPFipo9NMb6Ia0nCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-79ttlIdQPpyGqaRS7q1Mkw-1; Tue, 22 Dec 2020 11:25:11 -0500
X-MC-Unique: 79ttlIdQPpyGqaRS7q1Mkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1AA9190D376;
        Tue, 22 Dec 2020 16:25:09 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-207.rdu2.redhat.com [10.10.114.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D9B060C5B;
        Tue, 22 Dec 2020 16:25:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 18CC9220BCF; Tue, 22 Dec 2020 11:25:09 -0500 (EST)
Date:   Tue, 22 Dec 2020 11:25:09 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, jlayton@kernel.org,
        amir73il@gmail.com, sargun@sargun.me, miklos@szeredi.hu,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 2/3] vfs: Add a super block operation to check for
 writeback errors
Message-ID: <20201222162509.GB3248@redhat.com>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-3-vgoyal@redhat.com>
 <20201222161900.GI874@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222161900.GI874@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 22, 2020 at 04:19:00PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 21, 2020 at 02:50:54PM -0500, Vivek Goyal wrote:
> > -	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> > +	if (sb->s_op->errseq_check_advance)
> > +		ret2 = sb->s_op->errseq_check_advance(sb, f.file);
> 
> What a terrible name for an fs operation.  You don't seem to be able
> to distinguish between semantics and implementation.  How about
> check_error()?

check_error() sounds better. I was not very happy with the name either.
Thought of starting with something.

Vivek

