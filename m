Return-Path: <linux-fsdevel+bounces-37037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7349EC8F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 10:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7AF166498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AAD236FBE;
	Wed, 11 Dec 2024 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5tOqLQ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38B236FAB
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908906; cv=none; b=D5qEA8aYJ65COnnEY2Dg172XeyR6KhYTAN6C6M5Q3JTZEqRJR+V1ls6tzwfS/GNyOToNNzIqbVpnvEQ+BxcicnnJ+FI1JMHOMjTM3P6ZKqLVNJyRmI1fTuIUbjP/D5vBSxWGfnxAait5W4Xl0UyR00AVH/gwErRLQhjTB3tel+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908906; c=relaxed/simple;
	bh=8s9qU3NpcFIH9Ro8KpQpyXvRMnrSRjRKQsDDyH7NfpY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KXIn58OWzpb1UvIpmdk2/TS24tJ92X8roZGVcfNolqS9zP5kjVfDXK+/vIGQLi7b6+ZfZ0ZrnWU6OqBxwb1w1OmThcrxu33erQ0uXpx9XKybSHon6iDR2nRpRyMMt5bq6OHQeeQgiFBH48t/O2v1Oe3RHFlbNysoWn9yVdd9b78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w5tOqLQ8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361a50e337so7709345e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 01:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733908903; x=1734513703; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DLsS1CyBK/Moo7ZlFFxPYN1OuvOVl2Ay8BHF7WI398=;
        b=w5tOqLQ8gwo1ial/8x5zs3Ko239KwgcdYt2Y8xrAixNNRQ8Z9a+Mfk0EDhmHGOxIU3
         B3MUmKWLB0JUIZnWuF4F1lxnZK0SbmduZYNEgbtJPgrOyvetMtCm3wJaYE63rWGUd73a
         m3+xXHnEKEd4jnRqiWxgKv9riDgJqe7XCr4y0ov8JoogtX8JTAeAGQHstWfgLbKtqk9R
         Jkrd8xHOFlEjVxWg/tdR7Ri0ZNsTKatpxG4X9qgzyafM63aPAw4LnHkQHdMNdGipqlmS
         58sxhf5SUvnKkQS9C2fgAbGfBqBmWmI8iPm5cv4S1umnPBMpbU5qNOuBKk8J3gO6J3jx
         doig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908903; x=1734513703;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DLsS1CyBK/Moo7ZlFFxPYN1OuvOVl2Ay8BHF7WI398=;
        b=LPDrNdPZXBlaQ0TX+Lp2kqTHoiEosEbYbg81ivSXv8oWjtImznIaLdTx5zUxlF/pKU
         ET9LL4x24qsNcN67Nq2bZLgNf9AS/R/5mIqYBb9SYqVxrMbaqDmbxk+TgtA8+C4Ijnwe
         GdlYG9L1fCUULDQFgQIR3H/dBKsW7iVuW5S1hpZY9lQ3c4d+MfPa2otbbu6Nn14m9DYU
         4TXcaxLoCs73dtySU2ielipNyr6tj1GAMzgkN1ZnqwvQ2r5F9hEAAVpLvvygZEsLN0ig
         UVt4e1BPanDTwDnA9rJV4NK2XmfhtpQMflB93fX6rK8q3lKsOX+hv3HXxAyLEQxeWdaO
         iBJw==
X-Forwarded-Encrypted: i=1; AJvYcCWtRRiSOPvl6YO6gmMJHLE2tZm5iYZJqAD1+P7tD1oasd5QQEi5c/gLiW3+waygoqd9gVSgw+PthRSQABtj@vger.kernel.org
X-Gm-Message-State: AOJu0YwtT7NJnqeRwLThWHSWQMkL9eacJ5BPjro8w4ji7rjpMl3YgmtD
	Z9DrZa/bnf3RxvxWqPN5tz2YFHzWrq3NcR11fyIeaxqkCtGiN5FRxRggcyc7WqtwFTU3FDL4qTW
	Z
X-Gm-Gg: ASbGnctdocmjU1Wfja2PRfOFUUFksVcreNK1WLJZS9MtmzK4hfkyduy+5qejSPRP0Py
	zWdY0wC90NOmgw2l3dT8rhq5fpCy1fMJnzT6+6geN09t+BoQiV7CBjYJLwBIQF1TgJfsWzP2NIA
	lWm5KMW5fquwXQNqy642OlKZvXxaSMnQPIUf9cNhiOczPW9sPjVvEDVw9A/dt06L7Vj0ASS67Ig
	ccZF8UHhsJUF5Tx+BNR2AF/yLE4eKRw4EL8S6f1rbvwS0+IQjBjSj7wD7M=
X-Google-Smtp-Source: AGHT+IGPYeRitgpKtJOXyRZn4COfRNxYFbNQZ+CVZoA5uGWAMNXxGSSG6fybBnG6Xshn8ee/kKy9Ig==
X-Received: by 2002:a05:600c:1907:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-4361c3b9d1bmr13850245e9.12.1733908903351;
        Wed, 11 Dec 2024 01:21:43 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361e54ef20sm12271745e9.5.2024.12.11.01.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:21:42 -0800 (PST)
Date: Wed, 11 Dec 2024 12:21:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] binfmt_elf: Fix potential Oops in load_elf_binary()
Message-ID: <5952b626-ef08-4293-8a73-f1496af4e987@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This function call was changed from allow_write_access() which has a NULL
check to exe_file_allow_write_access() which doesn't.  Check for NULL
before calling it.

Fixes: 871387b27c20 ("fs: don't block write during exec on pre-content watched files")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/binfmt_elf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 8054f44d39cf..db9cb4c20125 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1354,9 +1354,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
 out_free_file:
-	exe_file_allow_write_access(interpreter);
-	if (interpreter)
+	if (interpreter) {
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
+	}
 out_free_ph:
 	kfree(elf_phdata);
 	goto out;
-- 
2.45.2


