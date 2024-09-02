Return-Path: <linux-fsdevel+bounces-28224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E679683AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6587CB242CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A230B1D2F5F;
	Mon,  2 Sep 2024 09:52:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F4D15C15E;
	Mon,  2 Sep 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270733; cv=none; b=gsZRvxcKggIUBkaGE1km02PxGCX8tWoE2fqyK0CH0TWc4HgfCJhjpqokKXyDuA27q4seXrZLacnJ7fk8TAJuDZdy71lh+z+xwDgPlAblIC/IJC5H4wZo6qYvvGopl8Zof9MeAultfWOL34sAJ5sMGccnUaYJeIENHvltjB3IkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270733; c=relaxed/simple;
	bh=VDV9Anucc7U9411QCjC+of6tnH6n+vj8XFAfe6/rSoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5xqQo3kQpUII5aVi2jLw3uyCfZLSwTvJvu87wEHhzauivdZPg3f5C1WSLuQFk7Ygsu11BwOaq8sCNuu2vOSCeWEzZ2jJ4aaZSNez1yyPJfOe5cPD6Efqjqac9NBbw+1MW9pNfsajafgk+VavarCm8/EfJQzyXlcWvx60MY2MLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a83562f9be9so370919966b.0;
        Mon, 02 Sep 2024 02:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270730; x=1725875530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPFmSaj7coQSAttoxzj1vOhb9+pMv8Cg49O405sE8AU=;
        b=JygyRWtriK1gicObtWzHVfzpMB6Yqn3s4xo3vlN8RJxTrahgkPL1aBIeurVdkjbxUf
         z169wcNuxHAVJOFhxoQXM75wcwAQQ0rPZp82gj+v6GgURqp+zP2q1nrXoCbP+vausX0r
         x91P2I+xFogZMI/dT8pfGAEOUiYAZHWp1ixRwl2+D9r3j0Vp0omAne0BH7ONoLu+N6Tn
         xQQWSL8AlqyczsgKpoT+vPJ/+A6SKTw2WHmB+i9IA069WN0cK/dh3LYg0ZSWsSyI6v+Z
         59WdmLKoY2bOgcAjHeMSuNQCEdv4kkdkHXxIA7KY5G4gA+hN87D7ZDFQHef7Z6C2xV+D
         Rn/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzioORS2jZr3keX0ptJEBfDEJVCDiwECReYLKxQrHjZVnL8At2XyVicVMWH/0SIahOO1ZGXI5J46Z9OaozBw==@vger.kernel.org, AJvYcCVDHAYf05Co08rMvyiI5cVqJQeQjS4CoOToYiz/LrDFOM6OvcasCuLYL3agWUiUWbZztTyY8xsqZ2ghFY3a@vger.kernel.org, AJvYcCVQl6Kl4qDLBHQYk7xRQREABPSeYuUATLyoiYuz2bNqRCJzpF+Q0UE6xUU9hYf1Oecv484coJJoZ4fF4si+dhWZ3TMTdBI+@vger.kernel.org, AJvYcCVtMlnBTWP0vMa16MM5UifxMTsfEw1g38TDepTM6ZVo3XYFjXZnY2l6+PHohXKPH/ai8QGUq9PI5xDyuBfEag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1FdIo4vgZsS/GR9eXN4Td9LLXcCviiy2hLVyqHUBnYt2b/xkk
	j1/I1yhnsXXROlSpWKTUbk2JOjpGb9iIJTYe5+yaR8zFWGV6I5zu
X-Google-Smtp-Source: AGHT+IFbXdsiiimIB03yggYoUOmWewJuFdD/owb35ZfSrgCsdk1w2zDvpPNMYffgXHvHFcnvX01leg==
X-Received: by 2002:a17:907:9488:b0:a7a:9ca6:528 with SMTP id a640c23a62f3a-a89b93c7cdfmr438069766b.11.1725270729071;
        Mon, 02 Sep 2024 02:52:09 -0700 (PDT)
Received: from localhost.localdomain (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f079sm535327166b.66.2024.09.02.02.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:52:08 -0700 (PDT)
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	jack@suse.cz,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Date: Mon,  2 Sep 2024 11:51:48 +0200
Message-ID: <20240902095203.1559361-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous version has been posted in [1]. Based on the review feedback
I have sent v2 of patches in the same threat but it seems that the
review has mostly settled on these patches. There is still an open
discussion on whether having a NORECLAIM allocator semantic (compare to
atomic) is worthwhile or how to deal with broken GFP_NOFAIL users but
those are not really relevant to this particular patchset as it 1)
doesn't aim to implement either of the two and 2) it aims at spreading
PF_MEMALLOC_NORECLAIM use while it doesn't have a properly defined
semantic now that it is not widely used and much harder to fix.

I have collected Reviewed-bys and reposting here. These patches are
touching bcachefs, VFS and core MM so I am not sure which tree to merge
this through but I guess going through Andrew makes the most sense.

Changes since v1;
- compile fixes
- rather than dropping PF_MEMALLOC_NORECLAIM alone reverted eab0af905bfc
  ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN") suggested
  by Matthew.



