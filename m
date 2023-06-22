Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466097395A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 04:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjFVCzu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 22:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFVCzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:55:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607FDC6
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 19:55:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25ec175b86bso4365060a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 19:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687402548; x=1689994548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjkLEUyh7hAdhBnJqtMqDRCiPAHo6VUCDcbn0ZEL1Hs=;
        b=DuOguYak2Ss74Z8WjCF14MujsqU+5sMCUP4obUtNSORtQ2o+BUvNS9xeDR+HmWPQoJ
         ndEbsaZd4npDouo6U8I7eMT1eXpEg+sLKfP3WBC/Avvr4fLk0nr8nkhhGLddHwFIgsm2
         PIn8Y/JAPzZSXqFlHsPdCNv9wFUTp0V+5Z8QJrtEo5JAAP5jYd8eRSzGA1UhA8zAIl9Y
         0+tGpEfTfJlWhm1UUhBQOnjpYrBi6EMRYmymNqC9kxIPegKEYQMujZKynvNvF7/r1Ptc
         I+Kj8cwu8z1zdAO14UMh2+doV0LXLgBJmTlp/nPbEMi6FiJqYYBQJeV/paGDfbjxM6At
         FdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687402548; x=1689994548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjkLEUyh7hAdhBnJqtMqDRCiPAHo6VUCDcbn0ZEL1Hs=;
        b=PMM/00DvzqkvcXI5fU693AGxtoC9RFOU5NrNTAfxWhoJxTL5/pcB3Id9o8KiK8s1nW
         yteajyMyU9QS4fEeNmWqcZlHS6ldo/fvbRVrA0wOtrkXNU36v8idDxijgZxRoWJH7qWS
         jXypo2EWb4UBds6EW8XAnTUZKln1ubL1fdFx3TFeodOqTnVudKBExoYkp57SQasarcpx
         5Rg63a2/fYHwoh4Sh5Ez3pOVCpjH1WeoUsdCTNoHowNMcNtVSugi3E/l039IWc9uvPpF
         ThLvt5rOvwV6lMa4jBXLFn0jwxa7A2Vwq/gxbVzEPiUtS9SZgPspJj9+Cwdc3Br9BIwy
         kuCg==
X-Gm-Message-State: AC+VfDxPeFh6Z7ECFmtnmPyMJfgDuPvu1uKuwIdB9KXSeXdEPoVKsUj0
        sF3J0h/9+qS70ZNWj607US4pfg==
X-Google-Smtp-Source: ACHHUZ7Yl/nhC7KM2uEsREuhjk/BjEss7S9sf9wUjyhe4Gp/LsTLNTf8KJ7pIRcAktNP021NjEZr+w==
X-Received: by 2002:a17:90b:818:b0:25e:7f55:d40b with SMTP id bk24-20020a17090b081800b0025e7f55d40bmr16896780pjb.5.1687402547809;
        Wed, 21 Jun 2023 19:55:47 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b001b3c33e575fsm4150325pls.95.2023.06.21.19.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:55:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qCAU3-00Egg9-1p;
        Thu, 22 Jun 2023 12:55:43 +1000
Date:   Thu, 22 Jun 2023 12:55:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] xfs: create a big array data structure
Message-ID: <ZJO4L56mB5o3BJ06@dread.disaster.area>
References: <168506056447.3729324.13624212283929857624.stgit@frogsfrogsfrogs>
 <168506056469.3729324.10116553858401440150.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168506056469.3729324.10116553858401440150.stgit@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 05:47:08PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a simple 'big array' data structure for storage of fixed-size
> metadata records that will be used to reconstruct a btree index.  For
> repair operations, the most important operations are append, iterate,
> and sort.
....
> +/*
> + * Initialize a big memory array.  Array records cannot be larger than a
> + * page, and the array cannot span more bytes than the page cache supports.
> + * If @required_capacity is nonzero, the maximum array size will be set to this
> + * quantity and the array creation will fail if the underlying storage cannot
> + * support that many records.
> + */
> +int
> +xfarray_create(
> +	struct xfs_mount	*mp,
> +	const char		*description,
> +	unsigned long long	required_capacity,
> +	size_t			obj_size,
> +	struct xfarray		**arrayp)
> +{
> +	struct xfarray		*array;
> +	struct xfile		*xfile;
> +	int			error;
> +
> +	ASSERT(obj_size < PAGE_SIZE);
> +
> +	error = xfile_create(mp, description, 0, &xfile);
> +	if (error)
> +		return error;

The xfarray and xfile can be completely independent of anything XFS
at all by passing the full xfile "filename" that is to be used here
rather than having xfile_create prefix the description with a string
like "XFS (devname):".

.....

Otherwise this is all fine.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
