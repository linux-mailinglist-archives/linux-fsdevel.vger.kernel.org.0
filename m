Return-Path: <linux-fsdevel+bounces-3288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB6C7F255B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 06:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D64B1C218BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 05:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A50199DA;
	Tue, 21 Nov 2023 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyFJ3EZx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B2E10EF;
	Mon, 20 Nov 2023 21:37:08 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cf57430104so16108315ad.1;
        Mon, 20 Nov 2023 21:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700545027; x=1701149827; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QrByEh4HtrdrZh+TurV7QStnfhXuPXFCWiwNep0ga/M=;
        b=lyFJ3EZxbmhn1A8WbKJwyxn3IuTylpoxO1EzU4dfa8HCr6jFC07lwWfiotVyRyPSiz
         u7Ca6akSBxOUVjxlAk9+hcvKpqonKwxOeKlRCJBC+QtcGDYIZPSnJGCqcjWUozmqITv4
         GuLjOxIj7moloEHWESPjWRQ8esU2GUJb/hvUvI1Gx+zqaA5d6Rd3a8go39idOB4fUYu+
         CXMnDrJbnEV6bVkR1HTZ5PoybwZTmsttA1ctYodChR9j1/uyTyx4dAnp6dS3PJJ2JQPV
         x1LH22SkXaEQTgc2w9ZpdiNM34SI9SlcMDTOiw21I/Abb1cl5h/QUTKv+awCVwhfumgr
         8EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700545027; x=1701149827;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrByEh4HtrdrZh+TurV7QStnfhXuPXFCWiwNep0ga/M=;
        b=op/pCVDj8IQT0OtMQQl3awXMJnf3JyHr/d63mEnsCK+CkR8QnvGwC939JRcmQF+RBy
         VBE42HaCpkOMTpL2cJsuS0hPi2MzB5cHFjfHVJTEEXpKtBDvuEq/IXGZtM+PLpbcsCnq
         e/JpGH94Yk8rRrqmPQjvHUfS8Tz3vjXGgjnLgFjRK2vrb+rsUx5prfw6gZIOnkotFoWj
         6cVwz6PjRGOrtdZR49vBFMFcO6bfUuR25Y8gAnD7JK/9QJnmw3fRUGsZfXdTLpbNuyWb
         CuocTliujZPYTE5itehEewFkJMea4en3+3PyHSLyNCvtmYCoHX0Q6aD5Bbiezb3sxRJY
         ivZQ==
X-Gm-Message-State: AOJu0Yzr0kH+YrUb1qVPQ3mYi/ef1n5nPkEg0ZFMMUmhdfVUQ/NZUV34
	wJU9KRKEmABAMii4bPQhClGjLtc7n4E=
X-Google-Smtp-Source: AGHT+IHrjYDFU/5fcDTmlV3i0L+bDqr5nK4xRZjP93bGVB4QcT5/TFL+feYNarEcP+XkAEG6Xjy1qQ==
X-Received: by 2002:a17:902:c94c:b0:1cf:5362:7e88 with SMTP id i12-20020a170902c94c00b001cf53627e88mr7961546pla.32.1700545026678;
        Mon, 20 Nov 2023 21:37:06 -0800 (PST)
Received: from dw-tp ([129.41.58.19])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c2c400b001c726147a46sm6939204pla.234.2023.11.20.21.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 21:37:06 -0800 (PST)
Date: Tue, 21 Nov 2023 11:06:53 +0530
Message-Id: <877cmby8ei.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/3] ext2: Fix ki_pos update for DIO buffered-io fallback case
In-Reply-To: <ZVw0gJ8uqzsdGABV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Nov 21, 2023 at 12:35:19AM +0530, Ritesh Harjani (IBM) wrote:
>> Commit "filemap: update ki_pos in generic_perform_write", made updating
>> of ki_pos into common code in generic_perform_write() function.
>> This also causes generic/091 to fail.
>> 
>> Fixes: 182c25e9c157 ("filemap: update ki_pos in generic_perform_write")
>
> Looks like this really was an in-flight collision with:
> fb5de4358e1a ("ext2: Move direct-io to use iomap").  How did we manage
> to not notice the failure for months, though?

Yes, it was due to in-flight collision. I found it during this conversion and
also noticed that generic/091 fails on upstream kernel.

>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

-ritesh

