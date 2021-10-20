Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87618435192
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 19:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhJTRqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 13:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhJTRqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:46:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B21C061749
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 10:44:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso1058543pjm.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rZMYnNDu/0rM3owyDyTM/MW8BYIa1O070l4Xazp++so=;
        b=U5SaYaUo2eX0uNis4u8mZfHAkZVzWf42GMVRAVaziDfgSXIuePi9CpoOiTEZJJbhyX
         pUjstIcxDcX2LKgtDuzAOop0obSqqu9usBn0VGqGAakm41Ov2VCjvwFDTrjm8oM9OzL3
         BRiP+fqx68PisOpxrc3UOOfXj6eOYxx4qrIX/22UBl1SwuWg727tCJJXUVB2O2kVaZ1E
         BygetQ3Pz1vC20sGynPgS+8Dqp2q9C9pn3yISoyAfek3UPzMTPeQeM7OieyXZ5WRVCN6
         qOusgfopWPRd+slExoufzwdh0j8llrMcyZcMpjTh+VbYTs6/poN/mCSRRC0kaqDizrgw
         0MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rZMYnNDu/0rM3owyDyTM/MW8BYIa1O070l4Xazp++so=;
        b=r7VB1tJJ78ifxeXwrMyGdpxi0M20W8Zeh/HjSUqzFHdABgxtGQCuTXCwxYA1PwMLEd
         s4gukAKum8lCw9gD3IofrFlw6DMvpnPKlR5mSRDtksGKH7Y647HqvceLB4E7s6z6RNRC
         wsOd5u3caCmtW+fb7ZjQ0C21RxASX4IiVahrGKFijMHi7rg/w9fZHCvxXQh9U8nk9J06
         iwuCdlY8yZhLOh4bSPx2YRnHi39+/lYp87sM0gUZvIaas7x2EGcT14b1lRmvTB09LBYy
         mF8Yf5WcNU7YMUoL+3PceV8+ZWFkzIanhEcYaEAUMAeh4sHSqSqq+VdpfIk3vSNhwTJS
         B5tQ==
X-Gm-Message-State: AOAM530yxXQzZLah67cWHmHY6NqMTYa2pPub6eZB8iKEPsgbdPGOdK2i
        NZo0xvlpo9p1JjZei/tM9dN9Uw==
X-Google-Smtp-Source: ABdhPJzQ+Ej8QpV04tDuNMK7gYYN4Af2SN3LnIiHhIYgGgqoTlXtXZ9ueAXGlJreogqlKOxEq53t+Q==
X-Received: by 2002:a17:902:dac2:b0:13e:f73b:6b5d with SMTP id q2-20020a170902dac200b0013ef73b6b5dmr467152plx.49.1634751849573;
        Wed, 20 Oct 2021 10:44:09 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:be9d])
        by smtp.gmail.com with ESMTPSA id c9sm2735057pgq.58.2021.10.20.10.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 10:44:09 -0700 (PDT)
Date:   Wed, 20 Oct 2021 10:44:08 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v11 02/10] btrfs-progs: receive: dynamically allocate
 sctx->read_buf
Message-ID: <YXBVaLzCGdj3wfkL@relinquished.localdomain>
References: <cover.1630514529.git.osandov@fb.com>
 <01efd9dd3a70c1a765549b16d6aa5c4cec8a67e4.1630515568.git.osandov@fb.com>
 <c30108b4-3001-2f6f-dd01-d3fb31f5d4da@suse.com>
 <dbecc5c2-c451-03f4-1a6f-cff09b934780@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbecc5c2-c451-03f4-1a6f-cff09b934780@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 05:35:42PM +0300, Nikolay Borisov wrote:
> 
> 
> On 20.10.21 г. 17:09, Nikolay Borisov wrote:
> > 
> > 
> > On 1.09.21 г. 20:01, Omar Sandoval wrote:
> >> From: Boris Burkov <boris@bur.io>
> >>
> >> In send stream v2, write commands can now be an arbitrary size. For that
> 
> nit: Actually can't commands really be up-to BTRFS_MAX_COMPRESSED + 16K
> really  or are we going to leave this as an implementation detail? I'm
> fine either way but looking at the changelog of patch 12 in the kernel
> series doesn't really mention of arbitrary size, instead it explicitly
> is talking about sending the max compressed extent size (128K) + some
> space for metadata (the 16K above).

Patch 10 mentions it in the changelog: "It also documents two changes to the
send stream format in v2: the receiver shouldn't assume a maximum command size,
and the DATA attribute is encoded differently to allow for writes larger than
64k".

And in send.h:

-#define BTRFS_SEND_BUF_SIZE SZ_64K
+/*
+ * In send stream v1, no command is larger than 64k. In send stream v2, no limit
+ * should be assumed.
+ */
+#define BTRFS_SEND_BUF_SIZE_V1 SZ_64K

You're correct that right now the limit is BTRFS_MAX_COMPRESSED + 16k,
but I think it's better if userspace doesn't make any assumptions about
that in case we want to send larger commands in the future.

> >> reason, we can no longer allocate a fixed array in sctx for read_cmd.
> >> Instead, read_cmd dynamically allocates sctx->read_buf. To avoid
> >> needless reallocations, we reuse read_buf between read_cmd calls by also
> >> keeping track of the size of the allocated buffer in sctx->read_buf_sz.
> >>
> >> We do the first allocation of the old default size at the start of
> >> processing the stream, and we only reallocate if we encounter a command
> >> that needs a larger buffer.
> >>
> >> Signed-off-by: Boris Burkov <boris@bur.io>
> >> ---
> >>  common/send-stream.c | 55 ++++++++++++++++++++++++++++----------------
> >>  send.h               |  2 +-
> >>  2 files changed, 36 insertions(+), 21 deletions(-)
> >>
> > 
> > <snip>
> > 
> >> @@ -124,18 +125,22 @@ static int read_cmd(struct btrfs_send_stream *sctx)
> >>  		goto out;
> >>  	}
> >>  
> >> -	sctx->cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
> >> -	cmd = le16_to_cpu(sctx->cmd_hdr->cmd);
> >> -	cmd_len = le32_to_cpu(sctx->cmd_hdr->len);
> >> -
> >> -	if (cmd_len + sizeof(*sctx->cmd_hdr) >= sizeof(sctx->read_buf)) {
> >> -		ret = -EINVAL;
> >> -		error("command length %u too big for buffer %zu",
> >> -				cmd_len, sizeof(sctx->read_buf));
> >> -		goto out;
> >> +	cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
> >> +	cmd_len = le32_to_cpu(cmd_hdr->len);
> >> +	cmd = le16_to_cpu(cmd_hdr->cmd);
> >> +	buf_len = sizeof(*cmd_hdr) + cmd_len;
> >> +	if (sctx->read_buf_sz < buf_len) {
> >> +		sctx->read_buf = realloc(sctx->read_buf, buf_len);
> >> +		if (!sctx->read_buf) {
> > 
> > nit: This is prone to a memory leak, because according to
> > https://en.cppreference.com/w/c/memory/realloc
> > 
> > If there is not enough memory, the old memory block is not freed and
> > null pointer is returned.
> > 
> > 
> > This means if realloc fails it will overwrite sctx->read_buf with NULL,
> > yet the old memory won't be freed which will cause a memory leak. It can
> > be argued that's not critical since we'll very quickly terminate the
> > program afterwards but still.

Good catch, I'll fix that.
