Return-Path: <linux-fsdevel+bounces-58279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E634BB2BDB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 11:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBDF1790D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 09:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF50331AF17;
	Tue, 19 Aug 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vECM7eRe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10DD31A046
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596482; cv=none; b=T/G+bZKdcB6C5q5bnPDsUcWJmO7CsD++OtmuRWN+nq4h6SgsEZHzHkcf1q6D9CyschpPWwpndkQEh7P3Q95nJ3bCgiR+usgerp6O70EVGLrHdn8MbVSZSx8yxYMcXjt+ojGbpWINXtiDumLiN5wlWJPm8tg3qBSv+/1gUu9WKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596482; c=relaxed/simple;
	bh=8OzrB53Bn5TxGHC664tdW+P0TA2+NR/DwiZkzjNkzZg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BI8KeM61nRCqqAE53piPGbeKsg9QDdk9mHOFLDZ0LJl6vqV7PuzmEyBQdixb7m0oLvcJo4P6s7KarrdLAmb+7Gb3eWxkTudlFK0oIMFSbMiGWHbmDYrOcKAfdBPA5mKe7X+hwO7nI+tDiiubRgKOMglp3aJpkbTVftjL2e8bkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vECM7eRe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9d41cd38dso3902722f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596479; x=1756201279; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKExw4rCJH6z3V+PveKbUj2X+7GksrW0bl8/wkUvABY=;
        b=vECM7eRed+zPnhTQQ6tRAwVWn5fTpl368Jau591Wr2fZij3Yr7XyNaVxSrPIjzKD5w
         U16QCwvxBZNdS3ZsHQ6cgPoyv9Bmlr3Ub4+W5BRNpGxEzumyL3Uj2nkzD51YcDGg0Lb7
         FK3qHQLqJ7VyCygn+ttLObvv+YOmIls+svsyHnG0bvIaNds/2ezTKyvyu8HOeG2Zi60U
         fuqEX/vstVyYMt+Qf0AfuqdeqwH7lyRoHhaZu3xtOiG0iVHqec9plpW5BLTs1IX3wXOD
         NK8c7/I/WvA9O0TvVPR//s1nf4R8Mv1FkLHOF4deJ6PHn6Xf+w37CJR6hGO+Wiwb3frb
         PJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596479; x=1756201279;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKExw4rCJH6z3V+PveKbUj2X+7GksrW0bl8/wkUvABY=;
        b=eW2jVSQq+xL6jRjnM2ZOH41PZT0DXjJHBYzH9yJOAzjognw/il8phn+525C9C4gB2A
         yWiVf3WHj2nveGGWJmT/5e+4ugoCD/D644zd2kyOXrCM1FQGAaqFUQOMVToYDB+Tot8U
         2tg5rP0cvrBdDBzUgtotkHqPiKBOlPbcnHr+iIx7xj6Zh0+JvAg/JXwayW9DcWeeG2wr
         IsO0MdyHKxY9KfztAJ/sxlIndE2sCmFcfHq/gd16W2kTTPiFqhJwAORXO/J6ljjFKF7o
         bPyN4d7g2SmAGj+2n+0TzSFlQlfT/k+O4b2I0vGljap4PhBJhXoM2Naioei+SIw0NHdX
         xLyw==
X-Forwarded-Encrypted: i=1; AJvYcCXoI5ecD9kgU42b8YsKMnY9ARdr3i1wSjlgmG9o1WJnWmP/slw91qvQ5wwAucbFAC2ewDCm6zOCltFh+5Dj@vger.kernel.org
X-Gm-Message-State: AOJu0YznX0fmzRjU+w3bEKhBKsek6Uo5mC9NMfOm2O8fFyBJ8FYRl0C4
	Fz/YiHK7N/5+bzJtUilzETk9BxiUFUGBxud6PbeK0C4YYDK18+wKPvcHQw6vVi3irlI=
X-Gm-Gg: ASbGncvgtmEBBSIFdfHP5wqbJFomgikLiPnKFRTtK7u74jRDCXHZWOAqtjabBTjmifD
	+vb/RMckC72uPmEVy24+ThbR1MULf0CeAKV8RJsgkAJmcKNZxOk3FaQfrUMwHCJSNyAjULTDjlm
	NOy4/rSJefFtjlilau0yFewUV2HUuUqgr9iImBtwFkfBB5nWS9mUW4Bhx3qFLC2tzKBteLn18J8
	paWB2cKV6YWTCzQzoxkRSAciOwR2UzwNdTZhn8ED01hk61SCO1rPDA9IEPrdOpUYuybKH0rIa46
	kU+ral/FxZMeVs1f0tXzBfNS8R5SJMFGOa28OwXiZa9vrYTHg9duhnmlaIlCRL1v7MsnVxMVasP
	HnGrDrVHW+C4ZwzCcxn/rfJ/whc4=
X-Google-Smtp-Source: AGHT+IFPnGBxUMbzp7/ciRb/4QDD/AoPuRkeVnisBhwmTgmtd+TF2XWKrPM0uJzG+Ht4NJS9oAj7Vw==
X-Received: by 2002:a05:6000:178b:b0:3b8:12a6:36b8 with SMTP id ffacd0b85a97d-3c0ec195bb7mr1400850f8f.46.1755596478926;
        Tue, 19 Aug 2025 02:41:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b42a97c02sm35092625e9.23.2025.08.19.02.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:41:18 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:41:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] coredump: Fix return value in coredump_parse()
Message-ID: <aKRGu14w5vPSZLgv@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The coredump_parse() function is bool type.  It should return true on
success and false on failure.  The cn_printf() returns zero on success
or negative error codes.  This mismatch means that when "return err;"
here, it is treated as success instead of failure.  Change it to return
false instead.

Fixes: a5715af549b2 ("coredump: make coredump_parse() return bool")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index e5d9d6276990..f9d82ffc4b88 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -345,7 +345,7 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 				was_space = false;
 				err = cn_printf(cn, "%c", '\0');
 				if (err)
-					return err;
+					return false;
 				(*argv)[(*argc)++] = cn->used;
 			}
 		}
-- 
2.47.2


