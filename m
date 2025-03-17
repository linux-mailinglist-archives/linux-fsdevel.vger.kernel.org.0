Return-Path: <linux-fsdevel+bounces-44199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1EDA652CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 15:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704F37AA7C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17607241665;
	Mon, 17 Mar 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGCFzqMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBE1DAC81;
	Mon, 17 Mar 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221218; cv=none; b=LqRjq2QA21sejvRtzeuGihXyxDskx8cEgtBL9WdgmL9tG0n+AQ4n4dQH9Z/1o0CSCExT0D8xgrR7SFVaDoSJFVSsFnXcnU+kCEnpIGDDCjrp1R58GGLGi91MjY2S6h5PFLGKB/z5nRyh1mV7Xw/g58fuYrOl9u2/JzD5ULfITDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221218; c=relaxed/simple;
	bh=XhyHwURC9+CP8pemGI0NfFA0YnuwTfrUw5S8OEx64IU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=h+YkZl1E3XFj714K8Nr46nU4TFg1DpWMjCK203qZ5jPpDC7Py8oel956ajllQPUV59AB0rtKZc9FY8G6lgDGYBmPdfjAbgMlYjFqNlSdsDgcbYSFNI320/QedumjNU6iqKbyQ6KIE6WmnOBShJGrQxLIboSYZzEFlhVqCbTfx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGCFzqMs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223594b3c6dso88123055ad.2;
        Mon, 17 Mar 2025 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742221216; x=1742826016; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mn6LOo+P9XtJ87ZI04DuUoHTU+5hgc1cTOgwmoIh8Cc=;
        b=kGCFzqMsRcXQPUDu42HWi2F6G83VIknczldFSsLM7FRk3RUE1tcWKI7m/VSwEEDLp/
         VpYn/oTi7KuKintbpGhzN74MpuCEcUAsKTWyLO6odmzK+KAU7w5uGGhTR9Gh2PNzmngE
         NTZQcDl5soom4o2/HUUrBzTT3Rm9jVCBxRGLj9urjgxpB8Ith+ZJopRGK/bvVGHt2kSA
         hVVFX5Wlqun0TVMI9JOBmgppQlZThaoxxOLonZyNwukfGYqf4ZUYBMYIqRlHO9V122DW
         CH97BkTMiGaBiOzBprc/GlurVPd0oygJb5np/NihFEpT0SCiOMP/DuEnK276QmhItEKW
         LKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742221216; x=1742826016;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mn6LOo+P9XtJ87ZI04DuUoHTU+5hgc1cTOgwmoIh8Cc=;
        b=uYIVC3tUBqMOQAyeB8qI2WuJVwknD1n9xIqy/FxetiZpR2Yh2VTWUp7W7glrha0DD2
         ZkfTf4DDVTJYIJv9rFYj2aYeEurZGUc9jWOeyNaxI26iP34Kn+/26Tqn2QGAaKDz5CT3
         9bq20VxpoBV/GqkzXpHsIPntPssj2WD3h1uxeAwn3tFNsxPMDK4x1Hc/Jtc6uja67LFn
         JNdVwYyLwao0CzY0jZWoEkLQKcjwwFSHQLGBnX9uJZ5AWKVcxwaFqmtr7Q3nfaDu8gyy
         DtkeMuOhL3h2KsAZQx7cIWDWuCsQyL0S30M58Wv2hBYpnW8fGYGCfGKlAMj5yzeHsrFf
         yUsg==
X-Forwarded-Encrypted: i=1; AJvYcCU27GHEZ70UPxuD98FaL7+UFFCTA8bgFQ2KgHp+TfeVLJl04EVe0hPYbFUBDsMBsCquWiwEWBvlQov46R3Y@vger.kernel.org, AJvYcCVsux032z70M+Tp7ST1m/2Ea6ddqdUU635IGL0+AFJIObeEjc9H3QAbq+8npqc+RDFNkHSuPGXTM+rA@vger.kernel.org, AJvYcCXZWK3/nwcWyuVZ9+DPKnAwgNi8bqYabiGHjqAcw/vK07DyRY9UiZ24GKMqrdFyn3Ijn/CCqF5kRwQpJyon2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzke7dsi/6R0XSwhOcOSd8nqtIKE2NbzO3vtOIgKbBnTruDUVGU
	qD/c3k/GcabPoZulPbYJH+cqmjhzDXfdctpzW/Ky8DsMROKxZW6C
X-Gm-Gg: ASbGncv8oZuMQ2bO9nHiuyK9GcB9DcYYVD8W6NIkZVY+aLaSUnkODtU6WIwhP7q3tSM
	qrPGMu/oP6rbgkwS1R/jYzkZeUItubkBKCS/YxzJ8NJ4mxmu51LcGf5ofFzAHBoOqjZuRcZG5xw
	qguGQeXEif558IF9DJq4iKVO5PA6RF4QbVFragCofS3oxEAeITbbOgShYAbhzRdOJtzEgaSc+2D
	k7FHBtYH5vVjHvCCrRCWYL0duLDw22pHfrkWuQ+B5Cc/VMPoZ82IJp2bZJnTVjVPBqqpUqUxIc9
	ApAM3pwPnsV+PuP1e/GkC9JuoDMMEK1FW6obUA==
X-Google-Smtp-Source: AGHT+IGV1CWprmcfxTUb24BvAmY8dTAt4IVm8P8AohmpcC8KXTXWtD2cv7EA/HFLs4YKHqZrL28FFA==
X-Received: by 2002:a17:903:230d:b0:220:e1e6:4457 with SMTP id d9443c01a7336-225e0a8dff2mr145717585ad.26.1742221216269;
        Mon, 17 Mar 2025 07:20:16 -0700 (PDT)
Received: from dw-tp ([171.76.81.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbfe22sm75580795ad.206.2025.03.17.07.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:20:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v6 02/13] iomap: comment on atomic write checks in iomap_dio_bio_iter()
In-Reply-To: <20250313171310.1886394-3-john.g.garry@oracle.com>
Date: Mon, 17 Mar 2025 19:46:40 +0530
Message-ID: <87senbspx3.fsf@gmail.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> Help explain the code.
>
> Also clarify the comment for bio size check.
>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/iomap/direct-io.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 8c1bec473586..9d72b99cb447 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -350,6 +350,11 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  		bio_opf |= REQ_OP_WRITE;
>  
>  		if (iter->flags & IOMAP_ATOMIC_HW) {
> +			/*
> +			* Ensure that the mapping covers the full write length,
> +			* otherwise we will submit multiple BIOs, which is
> +			* disallowed.
> +			*/

Nit: IMO, this can be clubbed together with your next patch PATCH-03 itself.
But either ways, no strong preference.

-ritesh

>  			if (length != iter->len)
>  				return -EINVAL;
>  			bio_opf |= REQ_ATOMIC;
> @@ -449,7 +454,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
>  		n = bio->bi_iter.bi_size;
>  		if (WARN_ON_ONCE((bio_opf & REQ_ATOMIC) && n != length)) {
>  			/*
> -			 * This bio should have covered the complete length,
> +			 * An atomic write bio must cover the complete length,
>  			 * which it doesn't, so error. We may need to zero out
>  			 * the tail (complete FS block), similar to when
>  			 * bio_iov_iter_get_pages() returns an error, above.
> -- 
> 2.31.1

