Return-Path: <linux-fsdevel+bounces-62090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59186B83EBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 11:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3C7482152
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 09:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D0B2C026D;
	Thu, 18 Sep 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEz2t9aX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0741F09BF
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189181; cv=none; b=W+QgK30HO06mU5QJ0tVK70a6FolCdhJPc3pG76ER2M9y4nrXB9zbpaKN3WRv0c/8m7zKFqzYrFHR5Jcznmw1agG88eS/KZAsJol2PcPhPdHseZ9mo5hwB05KfEz4M8ZNkqz+AoVZGVvDXfxvy6Kd8oyRwNwa5V4DuRym1+tI8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189181; c=relaxed/simple;
	bh=9NUcHiuwJ7yy7eIocMusuxX8hrBc3RhlUO2hxypoQxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TSX4G3+d4cKIasHq+vFD2UsZzTqIo7yHzEN8kmaedEx3rZo+PW1Z+MOQJNiVis11qnaZv7DSfR9+JY8FMjTtp+Eyzo8RsxHuuWGjwLpq8k0pk98aaitzNK0gKf+7dlK66UjezQbdenlEseFA3EUw2YYTHXt1h2sFWA3bwoctRow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hEz2t9aX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4619eb18311so4931465e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758189178; x=1758793978; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrCiUL75bZCAw4+y+WgmkA8zlr1SQwxLhmhWl+htlwk=;
        b=hEz2t9aXKEhir5Nk+ChxtrHLhkKTvBCvU8rvrYUqU9/elQhInakzHeH1I0/E/AQ/5s
         kyNqv+dia2t4sN1VM/p1pScq1GP/AOTaYGpY1ot32zt+YVFevgXxLCR/Jd74vZB1eJUH
         ritJ/aCGZt8wq9mi9FaLkP75Wdcu5YDK4QCTrUXiSRAJRGbKlsTAUBOB3K02U7e2Idlo
         +OUkATFJ0usreNE4gQp683D+zFQOAERQP+vaqf45poWsgmCt1NxFxGeRrL1+OVebBsCj
         n95uh3SWMw1T8+xKfTvQacb0b9fOm/6kcyvNmCVTxpgyGITWX3L2hlLnMe0dg0zOf5Oc
         5egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189178; x=1758793978;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrCiUL75bZCAw4+y+WgmkA8zlr1SQwxLhmhWl+htlwk=;
        b=SqnVFreCB/C5WBhHwKt/8SNRyH5wEBzcC0MOF5yGyh6u4c4ZNLMuhlvHCymKkwQpOv
         z1rk/e3aB7bjMreBT9VPaTrLJKXR2jFFyVkjnhzKcKruDHsiClIlkTYQrlrJiMo3US89
         JB3wxSI7vymsn+elhJ+lWyObY6MlWndS+XjNDHHqjnJLWp/MldxYI0qCRnFEJq+4mZww
         IRkJwXaL7bjcQ36FPtzTH2alMkdZj/YFktc1mNFfPyM81FOTZrJz/umAUW/x+KA8ei0w
         aKNkvAvfzlEd+27wY7Y5rxYJwRiSJRtMwFNPJTtIucTyQInkcJ8XC9jdy9sxGAO3x830
         6Fzg==
X-Gm-Message-State: AOJu0YwYgnJdUtdDf3HtBvy/CXrtZWOXZHkDdHtc8PRuMpP/PsUVmmdF
	Dwoo988Y9xFJUJJl9Q+a/3/enKdRvfCrWBulUhuwvH9xS4BZWAxaMTsrWLv/G0kkIK0=
X-Gm-Gg: ASbGncumh0UuP+qdhGF0vtQDPJRXEh1RXL5pu8g6+OPukPu9f4kSSnNtrGgCnNA7MY5
	RKrsmBDXkSNR8bowj1y1a/NGY4aMzz7gDBwxfeTUZRkEYWJRZOWsdb4G8HH1sRn0z9ht8y2w1X9
	yZXFYjJEici8R0sxo8zn0llpUvcRX6DNuFiwGM+WnpaQ9NHLAU14l/Azh0dHExM9+x6SPAzkVzZ
	LnFepCYTBdSwfrDZsRapfYcxJOeZWd2DFUb3uVvcNLFKSAc1/G2HY3heWLlmvDKQ37NIlYThpPh
	jKmiv+SfYD+rNBZR6PBem6I63a0bSOwxlvu+iwwtsUDDl5ICk/Fhad4I22R+WyLgPADStGEGCCt
	SqvOeEbPLtFU4MjsvhqR9yYEUKRYLI0DLuVgWayBmVT7U5g==
X-Google-Smtp-Source: AGHT+IEuhQYgzgTFbOZXUjahrTWsABPfUZy194AF4v8KaCUe4OxfBmwdar9IdKHdJilo4IGaTHcK7g==
X-Received: by 2002:a05:6000:22c1:b0:3ec:248f:f86a with SMTP id ffacd0b85a97d-3ecdfa37807mr4725910f8f.48.1758189177722;
        Thu, 18 Sep 2025 02:52:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee1385adebsm1167298f8f.42.2025.09.18.02.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:52:57 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:52:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] writeback: Avoid contention on wb->list_lock when
 switching inodes
Message-ID: <aMvWdo1EjHoPA-BH@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jan Kara,

Commit 67c312b4e9bf ("writeback: Avoid contention on wb->list_lock
when switching inodes") from Sep 12, 2025 (linux-next), leads to the
following Smatch static checker warning:

	fs/fs-writeback.c:730 cleanup_offline_cgwb()
	error: uninitialized symbol 'new_wb'.

fs/fs-writeback.c
    709 bool cleanup_offline_cgwb(struct bdi_writeback *wb)
    710 {
    711         struct cgroup_subsys_state *memcg_css;
    712         struct inode_switch_wbs_context *isw;
    713         struct bdi_writeback *new_wb;
    714         int nr;
    715         bool restart = false;
    716 
    717         isw = kzalloc(struct_size(isw, inodes, WB_MAX_INODES_PER_ISW),
    718                       GFP_KERNEL);
    719         if (!isw)
    720                 return restart;
    721 
    722         atomic_inc(&isw_nr_in_flight);
    723 
    724         for (memcg_css = wb->memcg_css->parent; memcg_css;
    725              memcg_css = memcg_css->parent) {

The concern here is that do we know for sure that we enter the loop?

    726                 new_wb = wb_get_create(wb->bdi, memcg_css, GFP_KERNEL);
    727                 if (new_wb)
    728                         break;
    729         }
--> 730         if (unlikely(!new_wb))
                              ^^^^^^
These are a common source of false positives, but I just wanted to be
sure.  Thanks!

    731                 new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
    732 
    733         nr = 0;

regards,
dan carpenter

