Return-Path: <linux-fsdevel+bounces-42546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E0A432BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 03:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EAD189DF61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 02:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B403CF58;
	Tue, 25 Feb 2025 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fuGjrflY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17863CB
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 02:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449059; cv=none; b=DSyakUs//lht5eORErw9NFqWtM+2RIAfzEtyhFRVsbBjeSl2Awu7XoXeFR5pmsjHMK+lpx0Nkhp17R/mlyPpBoYYKo3RJRUfNyIEu8KVxlSE1fXwMKyHwatJAoz4GsRb5OL/SAZ9KI5E5erpJxCSVwsVT4x34cnlKaw+7nwUHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449059; c=relaxed/simple;
	bh=quynGcB93SzFCptuyY4QyEzflUpirdUrMfOEoceQeqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4QZPW5E1Yl3125msq+OJ3ATnue+4kOxhNx2A6gdzDrqM7lQuFKS+Vb77qmMjWJF7wo5IouQdsh9W2iGvZGINleBmrvkTQ/gqB3TxvABRI/Wczkk5gM1oHqes7dSEel4Te0uyJuNDRdDZ0qxugSpc5VEWD4iwnQq9fwLL79R1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fuGjrflY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220f4dd756eso105234895ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740449057; x=1741053857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5alxhHLtmJ4/mCAgETlLemBWtmuyxJcYQLkKmoqRP0g=;
        b=fuGjrflYP+XK4rJkuE9kNnecx7Li0LsZo+ThgEbDoTzaTv0qSkiQ8VTfgzdmPMm1Oc
         mVcU9yl9Dr06ZhEYUXHSJuOaDBUs0YEKXmutl4jr5GeHWmZ8sF9Vn+uNsRmLT2XeDcNp
         yvQtjgg1qXhOChNYaCmrT8b3skICSZ9oAI0pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449057; x=1741053857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5alxhHLtmJ4/mCAgETlLemBWtmuyxJcYQLkKmoqRP0g=;
        b=KlbWCzMKI0dJ02rdYYfCAZ068pL4uyA5OpRGvWc71IcZ7MNJkeObkye6QKGPrs0A4T
         iS5DYlgUKWbM/G6IL/whbeSTJSlEIauQcZ5pSryZvnsCtcEF6ad1TTZZwc33FfgQ79wk
         ipUAkoIn5cJ8DMCgLUAwEXKRDD+GmcTFbUd/txtgSga2ntP6yVbkfbnicsBh/zK8TV5J
         ymzrfzj5huOuKijirm7qNVcNHX2cboB6ijLn1W2WETSfw7zgo5oGy454vwbmOqNZFZgA
         hTIu5Ne566OnJC4GGAZ5G3DUMJa4n2mC35oq5uuTKtT+UhsPx7YCtQqbQkyutrATLToL
         megA==
X-Forwarded-Encrypted: i=1; AJvYcCVPpSvUb0K7H27f+aieXrENKktsOwFHVsX9hWDl89PqqCXMRMlfORV45Ssz+f9il9TC0wFwB/sbmyZL5iky@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRNePDRBhoVPtoTc/JywnfyQBPJN9PXI6xSLozwLLOaG2BcSN
	9x1Fu8b2E9RgNZSe93GF38rj749EKYuTDOtjbsiWN389NKrniukKFELLkvwNHQ==
X-Gm-Gg: ASbGnctrXbSbxD5OXW+KVtQ/IHvuG/Fh10EN9La8UfnvUZCzRhKLTrXR5ZsyEYp7S4x
	H2vNLIKJ62VLwHapL5AwBOsuD6w9us87HN4cjmIEc3v1CkjZkLj+wsu9J7W5hHprLQQuhUUswuh
	95mNL+jAztspXXMJ4UW3kLWv3r5Jj015Df5+De6VpYEuDd9VFHQtyWLaOJ2ebnaZHH5mctB28kW
	IrtQFnsAGJDTPvC7USAKQNYzllbr7MKfkwl+LNyvjLHKH1Mb3dNvhiK6EJVGfEnGC+c9neLPbig
	lfzZ6qcj/rIy0XfFL3j+sTZGKWFwPg==
X-Google-Smtp-Source: AGHT+IG425pVoYoFNoPYRa/E6U3P+ywfI30S32H+Vjdu3k/+lBUB+TDpKDdrHMr/yRJUEnKcx2XdYg==
X-Received: by 2002:a05:6a00:1310:b0:730:9567:c3d5 with SMTP id d2e1a72fcca58-7347909fee5mr2392834b3a.4.1740449057013;
        Mon, 24 Feb 2025 18:04:17 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:ac62:4a4c:befe:d062])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81ec94sm331056b3a.137.2025.02.24.18.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:04:16 -0800 (PST)
Date: Tue, 25 Feb 2025 11:04:10 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH v12 0/2] fuse: add kernel-enforced request timeout option
Message-ID: <4hwzfe4b377vabaiu342u44ryigkkyhka3nr2kuvfsbozxcrpt@li62aw6jkp7s>
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122215528.1270478-1-joannelkoong@gmail.com>

On (25/01/22 13:55), Joanne Koong wrote:
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is in a deadlock. Currently, there's
> no good way to detect if a server is stuck and needs to be killed
> manually.
> 
> This patchset adds a timeout option where if the server does not reply to a
> request by the time the timeout elapses, the connection will be aborted.
> This patchset also adds two dynamically configurable fuse sysctls
> "default_request_timeout" and "max_request_timeout" for controlling/enforcing
> timeout behavior system-wide.
> 
> Existing systems running fuse servers will not be affected unless they
> explicitly opt into the timeout.

Sorry folks, has this series stuck?  I'm not sure I'm seeing it
in linux-next.

