Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DAB730D1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 04:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbjFOCRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 22:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbjFOCRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:17:40 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CC52728
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 19:17:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9c1735984so25551501cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686795435; x=1689387435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=85Z0uYT5Nl/EvJTfOgIEe7E+EGlrziVxkO6bFL1/58I=;
        b=WoS9AwF0Sl7PZaAkQ91Db0FDd6+zSdm0MwWCLvLRAO4jVKf53J4hCKnuG2Xr1NBrxU
         jwEoANHFxaRAUsz+qaBKAOUyfKqsKPOgMgSHViP0jf5ve8Tx78PCtYAXAZ9sjNaH2xh8
         jMcefhGnQKQLl5cy+RCUM+NozxwxhhBIY82nMMxLiHViYXXPtGuJ90p/dze1GXb2hmNx
         tUShCfLtRGgzdLO2/lJtjckVTeaYeMDmjBZFSfMnht7wHwgK+BSpy/4CYxiBZldOfCue
         eSiymuLshcTeHx1L76JatRV1eJWtLF7mODFwxgmp21uB9eUHHvxHugdn1mVLm7m77GRq
         vL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686795435; x=1689387435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85Z0uYT5Nl/EvJTfOgIEe7E+EGlrziVxkO6bFL1/58I=;
        b=YLk2JEh2LWIxJ8dm8zOh3y42tKROCAmBvax6rvyVd3hPBiJrXfsdV1YG3OwaiKk/Ms
         ETtRuMxxGkXU88wiqaA3VbYu1Wdz5H+w54PlHU2J41UYYuu7lIyjUaauobYIjBs22nkD
         DuxnZ5R8ke2RdDCLQa6SocpbVeEUgGSiYOceO2Hde+UC+qGsj1j3kdID7q6YSQapiWUM
         H+8tqtG3qQPysEHyvzuHHp2prsX31edp3vzRntPVxog4UKEZnwvklItJnf8VwWT/Pg09
         uAmxPuojUFxkNOoNFfqJbEffq37ufDRn2SXvaeUh7QG50btlHkiSRiC8lOh//BU3Ulqk
         qlLw==
X-Gm-Message-State: AC+VfDxjOs5wFN+PYBV23SyJ6SbIBAueq0EaoNU7GgvIEVFNV12KqD0s
        eNsRMSrM/ikHvaqYNaXiOzpcJw==
X-Google-Smtp-Source: ACHHUZ4goXHljgEoJlG9j+9Uj00Cw1Q5b8I2MZhOzdkqgDpqmjTTQ4qsL6jiEIQdHUJGaLdgSBJ9EA==
X-Received: by 2002:a05:622a:181c:b0:3f2:25e6:47bc with SMTP id t28-20020a05622a181c00b003f225e647bcmr3847309qtc.68.1686795435207;
        Wed, 14 Jun 2023 19:17:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7820f000000b0065e279c5c2csm10932058pfi.181.2023.06.14.19.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:17:14 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9cXw-00Bu0v-1F;
        Thu, 15 Jun 2023 12:17:12 +1000
Date:   Thu, 15 Jun 2023 12:17:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 4/7] brd: make sector size configurable
Message-ID: <ZIp0qH3CAMr1mGzX@dread.disaster.area>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-5-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614114637.89759-5-hare@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:46:34PM +0200, Hannes Reinecke wrote:
> @@ -310,6 +312,10 @@ static int max_part = 1;
>  module_param(max_part, int, 0444);
>  MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
>  
> +static unsigned int rd_blksize = PAGE_SIZE;
> +module_param(rd_blksize, uint, 0444);
> +MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");

This needs CONFIG_BLK_DEV_RAM_BLOCK_SIZE to set the default size
for those of us who don't use modular kernels....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
