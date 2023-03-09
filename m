Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DAE6B2148
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 11:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjCIKW3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 05:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCIKWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8986CE051
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 02:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678357299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Ir/h645vG7/3e7LKCiTYw/Yo812wpfTRDoEn9ipx+Q=;
        b=H0rAgnqZX6cXGx8PPESrS7+2Os1Zy3dVkaS6jpxxpIZbV8KIG6vyrR/dxiLamQJSFKmfJ5
        i4GoPlhkd2cdcRaOSkQOlJBfC3+f/mBRyGiqET0NzYGu5rpTjimL6cLvFp3XIXeZcNIS2d
        CEQA9BEi0Xk4TWgWe6XS+5SqdYRBK68=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-FLjRXR2JPZi0Xc-9SN72rQ-1; Thu, 09 Mar 2023 05:21:38 -0500
X-MC-Unique: FLjRXR2JPZi0Xc-9SN72rQ-1
Received: by mail-pf1-f199.google.com with SMTP id i7-20020a626d07000000b005d29737db06so988814pfc.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Mar 2023 02:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678357295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ir/h645vG7/3e7LKCiTYw/Yo812wpfTRDoEn9ipx+Q=;
        b=RzYv9PrGDl3GL5As/dlWWgfDFjMLltDvFDyRGMm7fNyZmVJyIZoc/RknXbGwqOEq6m
         fzfVyovwcX5FV9NerGB0z/rmuyyZ+TZIiv2z4A2t6H8159emDDGySYSeuJpZFoRpHG8x
         V1fipd0tKbGnEt1JWdRI7RLBeMB+vw4Te0ziTGjSM41xOYzve7w3kMACZQlFPiFeh1d5
         ri3wIKImFdZMagNJF+BAQpL+DGTZ7vjqJenJ7R6MlC7opsvlKuEyy0fjZZEP1fVYcErP
         FEWN5XOTRL0nw3EsC9dbDW4yqhCTQe8Jv5H0sKcyofHcAVlVufwakIBJb4mu8dbcrU3M
         meqA==
X-Gm-Message-State: AO0yUKXa1FFoqzwAo0jbm0fNN5i+sX72fnZ/h+olHeYuA+u+s5SRN36e
        3ev46VmL6pCPc9K1/Rs1SjCL58ZDZhFX0bq/QIN9MQSqj5cLdwFsG1hboDWdaJRnsl047dKCoII
        AOJyz9OaexKrZrRAjk4sW4xKK0+JW/pTzoHR1zLex4g==
X-Received: by 2002:a17:902:f7c1:b0:19c:a3be:a4f3 with SMTP id h1-20020a170902f7c100b0019ca3bea4f3mr8229329plw.4.1678357295487;
        Thu, 09 Mar 2023 02:21:35 -0800 (PST)
X-Google-Smtp-Source: AK7set9VDTf99mRyC2eJOBxIkMspHxJ2pV++2lzfcL1yIkpa4x+m9xdxgNtT/wUdeXHjX/qKTQaaMK9Wp7kJK/Zrno4=
X-Received: by 2002:a17:902:f7c1:b0:19c:a3be:a4f3 with SMTP id
 h1-20020a170902f7c100b0019ca3bea4f3mr8229321plw.4.1678357295164; Thu, 09 Mar
 2023 02:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20230309094317.69773-1-frank.li@vivo.com>
In-Reply-To: <20230309094317.69773-1-frank.li@vivo.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 9 Mar 2023 11:21:23 +0100
Message-ID: <CAHc6FU7vGD9NGn0phJsLEmcU8O7AaBS+hm=AEwYOc0nFGHS-hQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs: add i_blocksize_mask()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 9, 2023 at 10:43=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wrot=
e:
> Introduce i_blocksize_mask() to simplify code, which replace
> (i_blocksize(node) - 1). Like done in commit
> 93407472a21b("fs: add i_blocksize()").

I would call this i_blockmask().

Note that it could be used in ocfs2_is_io_unaligned() as well.

>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  include/linux/fs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c85916e9f7db..db335bd9c256 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -711,6 +711,11 @@ static inline unsigned int i_blocksize(const struct =
inode *node)
>         return (1 << node->i_blkbits);
>  }
>
> +static inline unsigned int i_blocksize_mask(const struct inode *node)
> +{
> +       return i_blocksize(node) - 1;
> +}
> +
>  static inline int inode_unhashed(struct inode *inode)
>  {
>         return hlist_unhashed(&inode->i_hash);
> --
> 2.25.1
>

Thanks,
Andreas

