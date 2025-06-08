Return-Path: <linux-fsdevel+bounces-50939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D880FAD13FC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 21:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37957A4BC9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 19:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3AC1DE2AD;
	Sun,  8 Jun 2025 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4dMXOHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF018CBE1;
	Sun,  8 Jun 2025 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749410480; cv=none; b=KJevW4XzOfyiSbmSindbuF1ZGr7iuFaY37xZ464AFl0P5+vOosiFJRAj6D1gQIiUieYsIH7LuhMg9aHJHjbjWJlnSdSI1xAgTSo5c9OmPpy9nJrtgw/aSm1AUc9JZxkxoQWmbN/BnilwpYdAkY5OASk4MP9tI81ptjYQ7QOMupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749410480; c=relaxed/simple;
	bh=3ToeU1ca+6r0saSxVUdrCK4VuwLa6RWZdBdAd06XbIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2+lX/KHjSIGEQfEGOl7+VWC9ORL18VkopANUH/HPDIaQvWvNRxuktfTJn22fh3JiUG1vZO2evylgGMi17xDmmvW6Z+y0z6wrWMWa6svFqZfqM0/gu3UAqzq++q3j9bLu6NecNNLh176n52OnPchfUATY2pw4Mb8O3746lw2LzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4dMXOHD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so7132317a12.3;
        Sun, 08 Jun 2025 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749410477; x=1750015277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=axkXAmtgO/Z3H+qRySn0u1KVlnnyFhbGyA6Cme92n6s=;
        b=T4dMXOHDTueU85g/zeZ9jYWZgphFGpZiNYbGSZjwF6bCjbsIiLN4LcB+MmqxiV/ZBX
         DAqhVLo4yeBynMXQB85O7+Zf74y8fXJab/+G9QUggj+UyMOuQ6jjFSr+SKxkJBm95MG4
         JtqQFTGTapURsoVOk5cpKOJ/BBkuhqYmfwyab+WsVk6HGog63WjXIiaLNvc0lBhmttJI
         TluTVNhRRSAJjXUHCE02U6LGHtc59mNX3KE8BTVw2WwXr4RTvkZ8UPcHldJqOb5pajCI
         FkTtenss2CXwVctnISzJ79elYeAIgxg22fSJTKmxgp5zMWpXn01WK8EI0lHpn9NndA7g
         uAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749410477; x=1750015277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axkXAmtgO/Z3H+qRySn0u1KVlnnyFhbGyA6Cme92n6s=;
        b=rh/QZpKz2WnfIj8O20ZDptvG5SSKXZrA7kBjFAMIVLEtuH0BzAY5NMBNNuDVfhSUdP
         0e5OnUZ9Y2Lh4lOITQsQRpr2YayYXpfezWYfjBLLZhjeuVnFbyv4oJYU5B1iQnWUHF2g
         alN/WL8mMROyyopVY3310RZX9mjdnQtjRs3TurDyHGwwx6N4VvDr7JT5aYRx2RK5kUdJ
         //QvPWW/xFDd6tzvVIux30Wht2p1orpmsehrvMQMYXGm4Z9RvFhiDBzTdgUJpkPainwl
         wk0wcwkimjIsd6afY8RZZvVTEl4uP0pPL9M4rLCeEpGpMcJqmTWX6OJFQazWHBcSPChW
         vm7w==
X-Forwarded-Encrypted: i=1; AJvYcCWTxPP8914MrSYNxLG74vsNZxESSTK8JD57l5lqkSRbBh3QoeqB5MzqZtl88klOi51/YVg/WVoTubLbthaL@vger.kernel.org, AJvYcCXVWaQcmusxCGn/3mG0y1IPxM7Ndre3jzCPfFOBM6S1l+yqwViIx2vvajxGmzT9fWlVdY/noq1kYoVJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yztb75iWwUOsviTVzKF/GKTxL3iu5W/rqpBRWLE9wBr9VgQMOKz
	P0Dq55m20bljWA8P03JI5wZEYS+jFIpiHD+T6m5gDY57FSAFN5Tk98tfV/TeSLmYeI95/Qb8vs0
	x9McCIjCwX5rJQvKxh8gqh7jw3ShOtqmD4geFoQ==
X-Gm-Gg: ASbGnctM8MTiD+yMh3CfQhGfC1MryabvjlXEoBpFMtFrtSLXIZOlGg7twNXKH1gv+c7
	BK3cgL4Yaya32xWSM/VgL3oAc7jq/m8TrqA6KEeNXFFwA4DLzGzhmrmYzbH9hcx57owuPqbJv6r
	azE4HcdEDro84XLHZpQs9HFBPRecGKMvrHRrLAqhntebYQynjxYJD7Z5r0LB8odwJIGAgFDjlhO
	Q==
X-Google-Smtp-Source: AGHT+IGYVRGVygfnby3Q8utlt0r38lS/RLVxMMVdFb1nq+vj+XM1nwg0YLCzcUbtZKhh4KjsCQ9np3UJbYpPSZ9SNR8=
X-Received: by 2002:a17:906:3c0e:b0:adb:4523:90b1 with SMTP id
 a640c23a62f3a-ade49efe4d3mr282676566b.23.1749410476978; Sun, 08 Jun 2025
 12:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com> <20250606233803.1421259-8-joannelkoong@gmail.com>
In-Reply-To: <20250606233803.1421259-8-joannelkoong@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 9 Jun 2025 00:50:39 +0530
X-Gm-Features: AX0GCFucseEISRPUNmxrN1I3e1gp6vFxEBHh1aQnV_7mFQxbgfelQ67fyn3Agk4
Message-ID: <CACzX3AtLjXawH2QX7eNx6PcdLcNS_jPwB3iUm11HkNGPfxkdVg@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] fuse: use iomap for writeback
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"

> +static int fuse_iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
> +{
> +       struct fuse_fill_wb_data *data = wpc->private;

Nit: missing blank line after declaration

