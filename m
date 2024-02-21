Return-Path: <linux-fsdevel+bounces-12210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB1485D071
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 07:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB033281D6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 06:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F473A8CD;
	Wed, 21 Feb 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/6q52NQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87683A1BD
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496540; cv=none; b=dudT/OXcBQstbN+jLQN9OfHTc8GhY9wlZNz8AylCqCWolqLFU/ppsSmZwFZHlQlaJNXnP9+b39c8Bu4ahcIixogu2ogFA298NehQq2pRUZwVnqNz2Y+YPqiT14ZeeOP2g9l55qmI4423ILrrifm2EZI/olBTGOCCWm68j2iYKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496540; c=relaxed/simple;
	bh=/ORo+31O3kd98nX0AZA5d+ZfF3faL6LqgJFwI5tHRnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t3L6MfnOYXf+Jth3U/GR7S7EGmZZkwo4cAblJlDFp5G49OWbaRGXY2t6W+OvMDlZKYAWFdqrLu3FijSBvdriJ3iJ59vWfBe4noZY+As14iahpmPI/djtCi4VAUY3G0n0F31C5kO1uYF84n0/JVjmMiWXRN/DHyUlOJ//mYbG8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/6q52NQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3f48422fb6so18598766b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 22:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708496537; x=1709101337; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=741qzZnNSG7KtGFvhuK+y/Zf676UMWnlta8zE4AAseE=;
        b=j/6q52NQw4ipEzh364CQo6/f6814vS8doLS6T3Ixue09CY11JWJqENN7z6tEtxetdz
         xIEzSF836DkQ8R/XIK+f4iAK3XX4qxfeuICWVgke3zs1Prgovk/nCzgTgkKdULcSF1IP
         P1mJH/GO7eLV24aan93ShYIjQraqICVqpuygMNe8y7Y0oFK8COKIBprfmx9DRXQkgCwb
         7EFvfouj+ZGvKA3DdWrUBhX+/dV2LAKQDk3YTx2KJ2sRlQbe8H+/Ef2Zd7JEL3j2VP+n
         CG+hKp1tY9uss2IjjI9/0KCjNInersxX+UjXsrIm2K73oFIBXJniAFF2CXNOCiKJWjeC
         8Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708496537; x=1709101337;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=741qzZnNSG7KtGFvhuK+y/Zf676UMWnlta8zE4AAseE=;
        b=q4aPZG8Q6b6K9T4SA3eRFjiLKPsRh+JJnMDODFyizy50Q9gRA8oSFq9wz0EC2L9YAe
         U6jfcS5LBv00LeekZauFq2sGoKxvdkOj2cvqLSxBUXpLIq2RINwavbYGmKva9UpBa8yV
         icPPYD6AFGXGx3sOCjEzxYQ2cdGUy0+u3WtUMfphswdaptvZfGWnBfWiGknWJb830VQW
         pMw/40ELmmWohAbbTtKcyDmVNE0eL850U3xnuBwkw3v28kt3KXBTgIkHJj+18oomRKyR
         Kk0ncNyF2gNikYqAtM0IvTrKW7vJ3cgRDDYONjpGhJOorvT49wfXta30JMC2Vd9gJtDZ
         dZfw==
X-Forwarded-Encrypted: i=1; AJvYcCWFepl46j8RIbCh53r6Iye6jB1QVrpxdJJ9Z/XAAFquIt5Uzoa4RhLMNBT+eGLxWX868ewciKJ99HfmdtIC0ujWywTLlnhmj97b6tlE3g==
X-Gm-Message-State: AOJu0YwuEzYO8dsBHEwlTf0fWPH8pgJpiAq6kBNr0L1gFn5YGZVmH1he
	Ha4jUh2lLJ8DX7+e0voruKWNQZgEhak/4mnEvNjePuJIsmNjG/VVmjqd/X7b0iE=
X-Google-Smtp-Source: AGHT+IHO2SpqxV7EEds5UnseQz6m895b8lvndStl3JKPg+YCA3YJ6jhNvZizr3ciEEIKub3G06vDkQ==
X-Received: by 2002:a17:906:6949:b0:a3e:9ddf:9f68 with SMTP id c9-20020a170906694900b00a3e9ddf9f68mr5159042ejs.43.1708496537367;
        Tue, 20 Feb 2024 22:22:17 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm3404027ejc.142.2024.02.20.22.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:22:17 -0800 (PST)
Date: Wed, 21 Feb 2024 09:22:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] mm: use ERR_CAST() as a cleanup
Message-ID: <5a64b69a-40a6-4add-b758-ec3a9d93eb11@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ->page is the first and only member of the folio struct so this code
works fine.  However, if we use ERR_CAST() then it's clearer that
this is an error pointer.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This was introduced in 2020 in 539a3322f208 ("filemap: Add
read_cache_folio and read_mapping_folio").

 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5603ced05fb7..54e9ebaf4e84 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3768,7 +3768,7 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 
 	folio = do_read_cache_folio(mapping, index, filler, file, gfp);
 	if (IS_ERR(folio))
-		return &folio->page;
+		return ERR_CAST(folio);
 	return folio_file_page(folio, index);
 }
 
-- 
2.43.0


