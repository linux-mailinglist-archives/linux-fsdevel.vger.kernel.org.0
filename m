Return-Path: <linux-fsdevel+bounces-3994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDADA7FAA22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 20:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B83D1C20D9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4563EA7F;
	Mon, 27 Nov 2023 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="SMRlyHpC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2ED60
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:20:40 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-dae7cc31151so4079677276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701112840; x=1701717640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lz0VBUYkCA7Kx1NWqS2WZCJC35ADqSHV6LKDgLTHFw=;
        b=SMRlyHpC8ue3IQGgrPRwHtmzGDf5v3tkNvcQRqLrZZhN7ZukTQrO5gtVG5e7qLIP0V
         REwfs0RRDFzBuYuy0/lKkKN3WxOCW05XHV1ig+cd4fhYy+MbhxSTP9hnDSnJOzMWajaF
         OP0w1eNKSWirYRL2yi6murGPMNjv3loqC6V6SRVLKkSQw90X00Ies0oYZR0TCkpQOPj8
         3VGVN66gXegTUzTpgoGCVCZB+lBp6lXBdz5VfFBrogwBgW3ZYt5EaxEYbBL6WdefJVrc
         gCqGMB/fhFn6ay9IGMPvb1sgwy0Id7dkjmZLDBDv1bTZLVNg3cGF0zqHCa1Y6YpZ4Imm
         LsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701112840; x=1701717640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lz0VBUYkCA7Kx1NWqS2WZCJC35ADqSHV6LKDgLTHFw=;
        b=CwyLJ5lKScSOED70qy/XIqXCpvKrkKXz/EXx8JS0FI18daapghce+FL6zJY/GI7gGT
         vjq+4dqc+z9cZvGH3Q0JvhG3JigdKBcnoQeZW64P+EPYnGJzMfFcdmsqF72qmy/Lpfy4
         +M4NmUbPm59yMr9ywxroA0h2h5Pm3H+Tpft+ugD8v1mORBQnpjLhMaGAPSyuwg1C4frr
         YnOxni64+/9wWu21srl/FNwWfPtZvp0BlEYMCdk+dcTEM5R6Q9v1fju/lcDTVQu5+/4X
         fh3t+e60nFkTPe7/LY8rT8CVc5K3lh8dVdal8ZdqMfUQpcdLmPeMkGG9OChbOsvWu9K1
         qo8w==
X-Gm-Message-State: AOJu0YwpaPh35dNOt8PDIFgx4umtqLxj1VMd0NaghTbN5iVxPTlmqDi8
	GuWbrFg4qGiEn85twbhDcbDOhA==
X-Google-Smtp-Source: AGHT+IELblu/nAnT6NTNLrViyrHmj+e3xGCNtbgpJFm8DcMJWcjE9oe9hHN3sjisYl8PjN6YkRs4lQ==
X-Received: by 2002:a25:ab82:0:b0:da0:3df5:29f5 with SMTP id v2-20020a25ab82000000b00da03df529f5mr11218973ybi.30.1701112839785;
        Mon, 27 Nov 2023 11:20:39 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g129-20020a252087000000b00d9ab86bdaffsm3246016ybg.12.2023.11.27.11.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:20:39 -0800 (PST)
Date: Mon, 27 Nov 2023 14:20:38 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/13] iomap: move all remaining per-folio logic into
 xfs_writepage_map
Message-ID: <20231127192038.GI2366036@perftesting>
References: <20231126124720.1249310-1-hch@lst.de>
 <20231126124720.1249310-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126124720.1249310-7-hch@lst.de>

The subject should read "iomap: move all remaining per-folio logic into
 iomap_writepage_map".  Thanks,

Josef

