Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D38039BC3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 17:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFDPxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 11:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDPxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:53:06 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF8CC061766;
        Fri,  4 Jun 2021 08:51:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id m13so7287724qtk.13;
        Fri, 04 Jun 2021 08:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uBZ/7zA0rgZN1i3qGEvYkxVHxjspKbk9HCZ8aw1XUNE=;
        b=bY59MWvfcUywNdjpMUbwtYEHsD11yoPOxdrhEQsx9FOhgynwo7kkXWedl9XQsAy9z3
         DUMRa5rEumkb0I6USrRgSlbMnbT1g2T0ibgeTGBHZujAdzzK0kYRF8HohIgYHAhRutdm
         o419IsVMLvjkT3XOL/qlApJniWX2WmLMNFU+Py1BjoYyjpb0m/FO6Ahr5GkwAnRijC3X
         ld/j5/pTft68bjR1Nh+DaF1pjzrlM1aT0U7oGqroUG5X8rDWLFSyVl0zNfRs/P2N09Gh
         oZ33WXpfnbxdaTVwqGIpxP/TZ6HzIFfhtyg0nocOAlJwxXvoTmiD3Xiwj5G5++RAZRg3
         YMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uBZ/7zA0rgZN1i3qGEvYkxVHxjspKbk9HCZ8aw1XUNE=;
        b=NY1lPjdJ7Xn8Zx/3Tf5uLZbQk+LvuWAgGsu2PLWZBAQAXLcRHzf6A6fcnAALgE0sCm
         A29WptnpYm2eVP64XN3RhfjswVHqcW3Wimr4u56u0Z8EKYLY/9QllS4j4hIRlTHwJyIv
         b0CDmcfBS5tn3/Tu1xwmXqB79tMHXUHYS+iSbIAPVPa091veZ8G7aNk+o/u9lLYZ7ZE6
         xLPIjsW2Z2zVzZCUbacAFFV5ZH+kKLOegJtdoymB9m5wla5/SMnrrIkEuhwPDVJ65MU1
         cx5hmG5FPrFUQjP1F3bOsWvB5EnjZ7Ramsmk7lB/BE51OmArEz0wrIB65V9lcgUE2CQ4
         VKwg==
X-Gm-Message-State: AOAM532W3CEfcUBv/hVs2zcI++CuuxpZRurpGWSZf4ggGJ1L1MXIFmom
        i6b81gHRj/EG6pDQleDWpWc=
X-Google-Smtp-Source: ABdhPJyu188ZUbkxyE/86Gh1Io9LR7qUTnlhY/CCRA7iq+vqTMqQDCZA+T5rHg0vLfahVTF8yCMxIQ==
X-Received: by 2002:a05:622a:ce:: with SMTP id p14mr1413541qtw.133.1622821864221;
        Fri, 04 Jun 2021 08:51:04 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id z136sm1079735qkb.34.2021.06.04.08.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:51:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 4 Jun 2021 11:51:02 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v7 6/6] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YLpL5lpaRSS8uhHl@slm.duckdns.org>
References: <20210604013159.3126180-1-guro@fb.com>
 <20210604013159.3126180-7-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604013159.3126180-7-guro@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Thu, Jun 03, 2021 at 06:31:59PM -0700, Roman Gushchin wrote:

> +bool cleanup_offline_cgwb(struct bdi_writeback *wb)
> +{
> +	struct inode_switch_wbs_context *isw;
> +	struct inode *inode;
> +	int nr;
> +	bool restart = false;
> +
> +	isw = kzalloc(sizeof(*isw) + WB_MAX_INODES_PER_ISW *
> +		      sizeof(struct inode *), GFP_KERNEL);
> +	if (!isw)
> +		return restart;
> +
> +	/* no need to call wb_get() here: bdi's root wb is not refcounted */
> +	isw->new_wb = &wb->bdi->wb;

Not a deal breaker but I wonder whether it'd be safer to migrate it to the
nearest live ancestor rather than directly to the root. As adaptive
migration isn't something guaranteed, there's some chance that this can
behave as escape-to-root path in pathological cases especially for inodes
which may be written to by multiple cgroups.

Thanks.

-- 
tejun
