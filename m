Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41323755AD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 07:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGQFOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 01:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGQFOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:14:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F44113;
        Sun, 16 Jul 2023 22:14:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666edfc50deso2402176b3a.0;
        Sun, 16 Jul 2023 22:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689570878; x=1692162878;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HmbjmIHb5GzdtgjkSga3gzSXDhWmYmZwi+CV2n6kZG4=;
        b=PlLNhXryEgq3/54re3aLsATRaR8/9jSdgaIWE89Lw3bIVQn9F1o391OSt8dakM3woA
         sszxIr/9Y+IuO52tc7d938qB+y3NYbwWoxDsB+amom5D5ZGoh+pRbIhglS4IO5kSBqXJ
         7dAkcPiwUUgjH4SCv0Gilfq1bejTh9+fTnvV+iYcJUiCETnAaBZNGkweYngNoLARo0Hy
         DbJCBsNCLF2tt8dAWKVNRhZEMd1XG0Fz7clz8hSjLB3lQf6H753CyNX4wWB3tV8sUmSr
         VOo6Em5pojdALI3p6JTwo+LBD616iJi4g73t772jBk3lQc2nU3HIKTE7jP4Y5ynnqvPC
         whgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689570878; x=1692162878;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmbjmIHb5GzdtgjkSga3gzSXDhWmYmZwi+CV2n6kZG4=;
        b=AumGlY5ghH5vVWI+xWKGBawsWpkeFxiBgsSnlqIGoErwd1zOW1kEHriYm2GY9ld6ij
         PHCoMZOMEsRqvp19iEw47NANt/O6F85BeC38x9n5U7+x8TN1x1rfr78S+KEEcRGnqaNl
         J63w1GFbmfHwEi8qn8T0qF7QE+8iRSxsBsYb69p49ixyH+X7ZLJ9bDDey5fG+OCpyvKn
         7bnbe5geWBJcrBHlb1d0DrV8NqTI795rnCt/gO9Qlb4Gt4SgWAO0XiUKbRoNKhMek3/M
         4mguLeANDO+Ee0bzqSOGA152NeXOK15awIzS4cNQeNi+Gabr7di/qDweY7WKIIH+FmAc
         Bs/Q==
X-Gm-Message-State: ABy/qLaBV5C2CyeWOmNHsQ2T47j84bbU+RFgJhwQSeOLVuHatDLeJ0BK
        PhU8C6VOIDOTvEe5JO14hJAaNOceTIE=
X-Google-Smtp-Source: APBJJlFuGMn8fmsc1LwgiSkW+tyUv3Be3DJW5hjQvSPcZKaTr+QdKGAjJks3M8GHTtMxI5B4AoydPQ==
X-Received: by 2002:a05:6a21:99a4:b0:133:bf18:ef7b with SMTP id ve36-20020a056a2199a400b00133bf18ef7bmr10223113pzb.24.1689570877772;
        Sun, 16 Jul 2023 22:14:37 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id f13-20020a63380d000000b0052858b41008sm11824721pga.87.2023.07.16.22.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 22:14:37 -0700 (PDT)
Date:   Mon, 17 Jul 2023 10:44:34 +0530
Message-Id: <87r0p7nmpx.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: micro optimize the ki_pos assignment in iomap_file_buffered_write
In-Reply-To: <20230714085124.548920-2-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> We have the new value for ki_pos right at hand in iter.pos, so assign
> that instead of recalculating it from ret.
>

Looks good to me. Feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.harjani@gmail.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7cc9f7274883a5..aa8967cca1a31b 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -875,7 +875,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  	if (unlikely(iter.pos == iocb->ki_pos))
>  		return ret;
>  	ret = iter.pos - iocb->ki_pos;
> -	iocb->ki_pos += ret;
> +	iocb->ki_pos = iter.pos;
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
> -- 
> 2.39.2
