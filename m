Return-Path: <linux-fsdevel+bounces-17422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 587ED8AD40B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 20:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5A61F21B76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AAB154430;
	Mon, 22 Apr 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k185uU2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EEC1847;
	Mon, 22 Apr 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810808; cv=none; b=ji+tzlOK3BNxXrMOu7EmQcEZloHQeG3lf9kYeB+jcvgis+9uzjD3tI+L/A6W0NxUu9766KFKQV0hDYT1b0ij30tfrsvn10bM/0E65hBdjwpsc6DyJ0Qey0Dp2MqwHgoahE6Cwk+bHJlJtPagpJuLmVJLPROinl2pAlMbQBB6v8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810808; c=relaxed/simple;
	bh=pIffCOrwnhOVcMUYLF99ICv6u38oFCkum6DNAE6cjZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D44GQo+qMEH4z/VNuEStFmuchu7JD5gZtCOlaw8BkkUyTBTOi4fpy2LtQFhzqAYphG4b4ceZYf0rYxu3yqDpGxNbBf38yJGAZ91+SpB/c76lJU5V7toRcPUbV+xqUhrjJrluQvdzcCwvYlt3nMHShqoT9lRCYwVHWuo1rCY43yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k185uU2e; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso4517094b3a.2;
        Mon, 22 Apr 2024 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713810806; x=1714415606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMGy8j1teFqioTyJb0XzaS3T9HzeNDiImKS46ZItRGM=;
        b=k185uU2eeiaSxb+VN5CdrrOvlo4kOfhPTqb+ENq0cnRytLwn/wXKM9h0jkk+MXwh9P
         j5+A+EDrGR3brOyMzYTXRPOF438EoP1SuWVaTtmVLhIgRvejvEb7YkzjHllevRN36UYR
         Rkvz6KG+/n+8QB6DuyYU5bXACCh0dQDhCt3IPKXjepUPQT9kSIeBc+T3/LtE0KaDJbMs
         LQ9vj23Hfgt2cTJHcd44kHgd+7JYFleW0WyMtj6O9BS81fn3e8g7P89PHRDYLelinGPN
         NQtKJTsJd1NTjVNTPCKnQtSzXYtPLvuJhQi1M0to6TNTtifQnLet3Iqf9nIUIY0JCcE9
         l4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713810806; x=1714415606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMGy8j1teFqioTyJb0XzaS3T9HzeNDiImKS46ZItRGM=;
        b=YS5K0JZB0Fr5KZXYUSSM92Ftz9+QRusznwRNvQ8BRECrLRIymoJqQ1dzL0+ccZ0Jbp
         KS73YlTuu+1fT3IvvC5BDzewZoF6YMhpZpWFtHi8dv+HgTwbQjUMMm9/nuP/nplDnQnh
         yEa0pmmcpL+KhHxZr6DhLQUfXcYVg/t26StJbTf7rQ11Nmrt1gI5O625agDXg3+Ym9VA
         FG3NN9RGURsqeTh1tynK/CNdjUvfmtA/1h8Ayj/BwhNyOuipchfDEHaxaN1LAosC9x4M
         tHGIvMyFqAkZqKi6ltCrCyhVPEqBdIyrS2tul2wEN0KK9X2rTgo6ACFKNDi8hvrAhIJC
         ztEw==
X-Forwarded-Encrypted: i=1; AJvYcCXkI4ymvu3Agi672IPUN3UWLWN7mEor2b35AfLrc+xyE5o03J8K4zjVmYOzxgnw8Q2gytqBxqhcQ7EOq7sT3BZslldegVEer8lYecPNc/Nf5P3R5Age1Lf8tO5LM2AXAClGzuDX2nc+t8p/YA==
X-Gm-Message-State: AOJu0Ywfs2FTTedp2eCpyBugWEQoij3YaD0/ws+P02J2BwD0TgbVfd9K
	i347K+p6nOioD1QUQqCsVxBo9p8dZrHQX4bupmfAmDjXNRuG68Kg
X-Google-Smtp-Source: AGHT+IGuJgfd+b3a7MjTSff4bidbs0kD+rGha+REJuHW/EoJaa6eNZZb1fiPY3bMNVlylFneY3VGdw==
X-Received: by 2002:a05:6a20:914e:b0:1a7:2ceb:e874 with SMTP id x14-20020a056a20914e00b001a72cebe874mr15745697pzc.37.1713810806244;
        Mon, 22 Apr 2024 11:33:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id t11-20020a63b70b000000b005fd95f84173sm2705581pgf.66.2024.04.22.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 11:33:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 22 Apr 2024 08:33:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
	bfoster@redhat.com, dsterba@suse.com, mjguzik@gmail.com,
	dhowells@redhat.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] writeback: rename nr_reclaimable to nr_dirty in
 balance_dirty_pages
Message-ID: <Ziatc6j4ohBTEZUQ@slm.duckdns.org>
References: <20240422164808.13627-1-shikemeng@huaweicloud.com>
 <20240422164808.13627-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422164808.13627-5-shikemeng@huaweicloud.com>

On Tue, Apr 23, 2024 at 12:48:08AM +0800, Kemeng Shi wrote:
> Commit 8d92890bd6b85 ("mm/writeback: discard NR_UNSTABLE_NFS, use
> NR_WRITEBACK instead") removed NR_UNSTABLE_NFS and nr_reclaimable
> only contains dirty page now.
> Rename nr_reclaimable to nr_dirty properly.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

