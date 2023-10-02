Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051B77B51AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjJBLrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbjJBLrJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:47:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178CEA6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696247178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4wiA1IyLo0If38IR67mUW3u+0/NqaN4gYG2HXR0jpk=;
        b=ed8iv3scqyUiZ4kNxFvS1eDidWsAbW6n0ei4sLK+Drc5qNvGqcxGJMZc7omSzfXl13WmNZ
        h1+RQVMT68OY/PcP+jLAdXqqIwhzpV+VgGpVhklF8iQJHtUQXvmMyApXGDZlUyhffr3c4X
        PvQv2kyu3Vd/qFAftdKu8Tk7rkjDVho=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-vIRc2ifYNJKBMsUW2qVX-w-1; Mon, 02 Oct 2023 07:46:07 -0400
X-MC-Unique: vIRc2ifYNJKBMsUW2qVX-w-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77577616e6cso966173585a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 04:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696247166; x=1696851966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4wiA1IyLo0If38IR67mUW3u+0/NqaN4gYG2HXR0jpk=;
        b=BucA5a2WrKgdz6KxMpE2LTUWFqP+SnFOmse7zNkcbAHQG6LwaBEeAZXNp0aw2pIYre
         qI8KMwRLuULNMe+RHRb3sN28kY8cdBY/LcfheIKPuAAz1xI10713r4/i+rLGUCL7STz7
         /aaPgp3nQFJJCqGINXwI4KnIclxDccTDrECh44WFIwuFmePdL8tJkVxPoxBcKlsWjyL7
         4or9bex1W5XdTVL/K0TW3rgBSSGtxM7c5HYOHqVmRP6N62L0Pn/GpyEl7n+HldKMkijt
         ag6RkN9mdZKqIBY8Kqq/r0ZwsiO3YBHv0Tk3dZDV4eLd45hRuxMwT/9F32xzCVPPf4zJ
         Q6Jg==
X-Gm-Message-State: AOJu0YyvDWXlvfbgSdu2lPbB/aBY/oYsOnHlXVxoX2DkbBJAumNwMgg0
        7TTDRziAzJsqw8Y44LoucKjl9kLLL+2XYjqCX6T22oC2fLhq99A/zH+GHcIPwPUEdojhw60nosl
        83SQW2rdpTIPU8rHXCT9Qi24PQQ==
X-Received: by 2002:a05:620a:2415:b0:774:1b3:6185 with SMTP id d21-20020a05620a241500b0077401b36185mr12471657qkn.19.1696247166760;
        Mon, 02 Oct 2023 04:46:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfAq7ep+pkYI0KdOdrBxHQxEumwOmIcqdz4FjV+otsaoDlt04YI2JGp6jQUQkOOtjbR3yXIQ==
X-Received: by 2002:a05:620a:2415:b0:774:1b3:6185 with SMTP id d21-20020a05620a241500b0077401b36185mr12471641qkn.19.1696247166509;
        Mon, 02 Oct 2023 04:46:06 -0700 (PDT)
Received: from [172.16.0.7] ([209.73.90.46])
        by smtp.gmail.com with ESMTPSA id a13-20020a05620a16cd00b0076cbcf8ad3bsm6820810qkn.55.2023.10.02.04.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 04:46:06 -0700 (PDT)
Message-ID: <7f422261-92ef-32df-6640-dab9d68e1023@redhat.com>
Date:   Mon, 2 Oct 2023 06:46:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 08/15] gfs2: fix an oops in gfs2_permission()
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20231002022815.GQ800259@ZenIV> <20231002022846.GA3389589@ZenIV>
 <20231002023344.GI3389589@ZenIV>
Content-Language: en-US
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <20231002023344.GI3389589@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/1/23 9:33 PM, Al Viro wrote:
> in RCU mode we might race with gfs2_evict_inode(), which zeroes
> ->i_gl.  Freeing of the object it points to is RCU-delayed, so
> if we manage to fetch the pointer before it's been replaced with
> NULL, we are fine.  Check if we'd fetched NULL and treat that
> as "bail out and tell the caller to get out of RCU mode".
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   fs/gfs2/inode.c | 6 ++++--
>   fs/gfs2/super.c | 2 +-
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 0eac04507904..e2432c327599 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -1868,14 +1868,16 @@ int gfs2_permission(struct mnt_idmap *idmap, struct inode *inode,
>   {
>   	struct gfs2_inode *ip;
>   	struct gfs2_holder i_gh;
> +	struct gfs2_glock *gl;
>   	int error;
>   
>   	gfs2_holder_mark_uninitialized(&i_gh);
>   	ip = GFS2_I(inode);
> -	if (gfs2_glock_is_locked_by_me(ip->i_gl) == NULL) {
> +	gl = rcu_dereference(ip->i_gl);
> +	if (!gl || gfs2_glock_is_locked_by_me(gl) == NULL) {

This looks wrong. It should be if (gl && ... otherwise the 
gfs2_glock_nq_init will dereference the null pointer.

Bob Peterson

