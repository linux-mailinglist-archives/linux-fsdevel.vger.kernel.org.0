Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDC552C1A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 19:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbiERRoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 13:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbiERRon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 13:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F3A5719DA
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652895881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dzen8Tfphka+V9v1rHHzLeFthFMVB9wbjOwentfjkpk=;
        b=ZfsD2M2r0Bnzy6buY1/Unafs1pvUIbsfnhqsZr3FoVj+VSLr/yWdkxwcXtQY3qSHlBTy+5
        xZO0qdBvLKL0ujOU7f1ftufRi7JdXNIJhaUAhYBDCdT7ZhKoDLCErE5gOjiayQhLm6yuDD
        /zKVt+WcNz1X1sFndPqpx8PXzyadHlY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-tP__qQLGPtai9qnYDgv2xQ-1; Wed, 18 May 2022 13:44:35 -0400
X-MC-Unique: tP__qQLGPtai9qnYDgv2xQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5567B811E78;
        Wed, 18 May 2022 17:44:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 476FC2026D6A;
        Wed, 18 May 2022 17:44:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0949F2208FA; Wed, 18 May 2022 13:44:35 -0400 (EDT)
Date:   Wed, 18 May 2022 13:44:34 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        bschubert@ddn.com, Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v5 1/3] FUSE: Avoid lookups in fuse create
Message-ID: <YoUwgoAHiywYzvpK@redhat.com>
References: <20220517100744.26849-1-dharamhans87@gmail.com>
 <20220517100744.26849-2-dharamhans87@gmail.com>
 <YoUvrSdh4B0rKy78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoUvrSdh4B0rKy78@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 01:41:02PM -0400, Vivek Goyal wrote:
> On Tue, May 17, 2022 at 03:37:42PM +0530, Dharmendra Singh wrote:
> 
> [..]
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index d6ccee961891..bebe4be3f1cb 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -301,6 +301,7 @@ struct fuse_file_lock {
> >   * FOPEN_CACHE_DIR: allow caching this directory
> >   * FOPEN_STREAM: the file is stream-like (no file position at all)
> >   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
> > + * FOPEN_FILE_CREATED: the file was actually created
> >   */
> >  #define FOPEN_DIRECT_IO		(1 << 0)
> >  #define FOPEN_KEEP_CACHE	(1 << 1)
> > @@ -308,6 +309,7 @@ struct fuse_file_lock {
> >  #define FOPEN_CACHE_DIR		(1 << 3)
> >  #define FOPEN_STREAM		(1 << 4)
> >  #define FOPEN_NOFLUSH		(1 << 5)
> > +#define FOPEN_FILE_CREATED	(1 << 6)
> >  
> >  /**
> >   * INIT request/reply flags
> > @@ -537,6 +539,7 @@ enum fuse_opcode {
> >  	FUSE_SETUPMAPPING	= 48,
> >  	FUSE_REMOVEMAPPING	= 49,
> >  	FUSE_SYNCFS		= 50,
> > +	FUSE_CREATE_EXT		= 51,
> 
> I am wondering if we really have to introduce a new opcode for this. Both
> FUSE_CREATE and FUSE_CREATE_EXT prepare and send fuse_create_in{} and
> expect fuse_entry_out and fuse_open_out in response. So no new structures
> are being added. Only thing FUSE_CREATE_EXT does extra is that it also
> reports back whether file was actually created or not.
> 
> May be instead of adding an new fuse_opcode, we could simply add a
> new flag which we send in fuse_create_in and that reqeusts to report
> if file was created or not. This is along the lines of
> FUSE_OPEN_KILL_SUIDGID.
> 
> So say, a new flag FUSE_OPEN_REPORT_CREATE flag. Which we will set in
> fuse_create_in->open_flags. If file server sees this flag is set, it
> knows that it needs to set FOPEN_FILE_CREATED flag in response.
> 
> To me creating a new flag FUSE_OPEN_REPORT_CREATE seems better instead
> of adding a new opcode.

Actually I take that back. If we were to use a flag, then we will have to
do feature negotiation in advance at init time and only then we can set
FUSE_OPEN_REPORT_CREATE. But we are relying on no new feature bit instead
-ENOSYS will be returned if server does not support FUSE_CREATE_EXT.
So adding a new opcode is better.

Thanks
Vivek

