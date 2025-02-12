Return-Path: <linux-fsdevel+bounces-41586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09502A32729
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E5D7A3A10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F54920E33B;
	Wed, 12 Feb 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ORboCTIQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5A1F94D
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367049; cv=none; b=TnVPxaACbcb6eIkz8KwXnb3kxr3F4NO5RN/ZZlkrjl+OjZk/S25lwEPHSO/SxStkgcmT0+PDFPy3fWsEb/1Fld2gl9O8lZuzm+KSiTe149UfZuJCKt7lI7Zhl0fUfKXwTTObyWUjk0m+9fwOHWnAzhqjDx1F7XKuKoKDyUI0qVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367049; c=relaxed/simple;
	bh=nUnkYKb9DtuWZPttwPzjhmlIoUfllw74KrzEyOumd9U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rYQPS9UlpDovfNpB9CaNnbiFgfQ1PU6dnX5K4IWItu14qcHwsz8nToqHiQekkwg3LHLmwbrlAZ97BLp2Em2PC9JeQc1J0XYpMer49HIcArhdeyCCD16c/QsVom0gPiZogzh1vZzItAjnV5Sqcnob4KOZPcGRZ2OD+wyO+GKVZlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ORboCTIQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7f860a9c6so102710466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 05:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739367046; x=1739971846; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7ZanJVIGTIbu9bNf2w1yw8S2WmPY+mHV2EsTiadKn8=;
        b=ORboCTIQ7tUJC+cJEtjFLGH/IcgiyYAkIGoFgzJABgav/82NPM1qO+3Us7aoF6OHul
         yR/+HWn6xGQoHZwsXoJMdnxch9TNVuRjv7wv/4SCyV/XPSddn7kARNUka5ohNmR5HKyl
         7CnftXu6JhFNlYKN/xvpUfa0oyy/mHl59Syp/0LqmdFovL6HkIqv4RdRDteTNmhpS/P6
         clcqhBYEYs0KWpv5J7Oe5cFigeEq5rlTpscJNzKQbmfcSwZXduTrQ2koVS/1fTY5Ot0r
         fpFHnsrutR+uLKkZRwIKHa/kN/Bs4aDErXI4eYehvgzLoeRysQ1QlwjxEDuyqzFCyU5Q
         BgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739367046; x=1739971846;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7ZanJVIGTIbu9bNf2w1yw8S2WmPY+mHV2EsTiadKn8=;
        b=SnxmA3/wUwayHL/Mn/RNj2kAKrNvx8k62KaTZ+Ed3QyWtQ4GCAvLbz4q0r8o38yPLe
         NmBnaju48NgO2FDP2AxS/QqjEz6dBXkEhLR7iYZCgSVU3lODRrj1bqId4bGHomxdBon/
         zO+MyWR/+oA2URKKt89U9niqhOWnpum8TMTTed71ES+2JrS9AHM3bVVzN7k7JHxEOuUe
         wUnl/AsGgbgMjln4d54D4uPRHIlvCBG/oSd0kFPdf4OqZQOkTuFYyjWum8mW68fuGbyF
         H0gZV2CwkQBNScn2OQVzXItySRcgA1sk1KFRdP9T+Thj4D6NwojhdCT1uAxGiTFSDnjH
         DxEQ==
X-Gm-Message-State: AOJu0YzM9Bw96kf5shMqCFLcxwthE0KmeuTugSAl/eHqbGW/x0OCSUuO
	BfPlvDTpxWdka9Hu5yFJKnTVCyuGn/mijJrRDMeOPAoAE515OUViOPsUQZRwGNjPWw9CWMhsudT
	u
X-Gm-Gg: ASbGncti4kLFe9L3yt4RhffHSzzQCe8pXFXPkpRO+2+htblSKW1azXoYqrUzjfTmy6u
	rhxYmd0UzuHkjjcxYQjt/iVNQwvdG+gLNd/mCcWqndfIBn4fPaquPnZrDyC2LdAMgD7Ihzqy5ng
	RtVhXBDqBMjvwS6nbYYVR/IddGQnzmxYLYZQzg8nuvaO9nGdpnmikPsZevdQKSs26zVYmjfFHQJ
	Iref1WvcB+OGez8bnpp8cuHJRUwz8xMvF1X5+/8Td2RY0nONft+wPu27o+GdcWv62eELoXYyIXv
	k6JKC2iF1MFR3SfeAvdW
X-Google-Smtp-Source: AGHT+IGnTSnz+oDAXqL0dr4i3ermwFe17mVsJh2LxnV44B+RTnRJbK1ibDprskibzUfizL0xt5vWDg==
X-Received: by 2002:a17:906:c10c:b0:ab7:d6c:5781 with SMTP id a640c23a62f3a-ab7f33a1557mr303890166b.24.1739367045901;
        Wed, 12 Feb 2025 05:30:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab79298641asm1059172366b.90.2025.02.12.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:30:45 -0800 (PST)
Date: Wed, 12 Feb 2025 16:30:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] statmount: add a new supported_mask field
Message-ID: <1a2f8a59-f332-4f20-a8ff-4d728312e9fd@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jeff Layton,

Commit 945eaa26b049 ("statmount: add a new supported_mask field")
from Feb 6, 2025 (linux-next), leads to the following Smatch static
checker warning:

	fs/namespace.c:5640 do_statmount()
	warn: was expecting a 64 bit value instead of '~(1 | 2 | 4 | 8 | 16 | 32 | 64 | 128 | 256 | 512 | 1024 | 2048 | 4096 | 8192 | 16384)'

fs/namespace.c
    5630 
    5631         if (!err && s->mask & STATMOUNT_SUPPORTED_MASK) {
    5632                 s->sm.mask |= STATMOUNT_SUPPORTED_MASK;
                                       ^^^^^^^^^^^^^^^^^^^^^^^^

These are all declared as unsigned int but s->sm.mask is a u64.

    5633                 s->sm.supported_mask = STATMOUNT_SUPPORTED;
    5634         }
    5635 
    5636         if (err)
    5637                 return err;
    5638 
    5639         /* Are there bits in the return mask not present in STATMOUNT_SUPPORTED? */
--> 5640         WARN_ON_ONCE(~STATMOUNT_SUPPORTED & s->sm.mask);
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is fine for now because the high 32 bits aren't used.  I guess when
we add a ULL constant this warning will fix itself...  So maybe it's
fine.

    5641 
    5642         return 0;
    5643 }

regards,
dan carpenter

