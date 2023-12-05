Return-Path: <linux-fsdevel+bounces-4873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631E8054F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 13:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D876B20F65
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F43056476
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejVA3s9u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09474AA;
	Tue,  5 Dec 2023 03:38:53 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58d18c224c7so3357622eaf.2;
        Tue, 05 Dec 2023 03:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701776333; x=1702381133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qxXMKWwt2qwPzzAZ0CM5xsYQyZ6d7IRS++BuZ2zfHg=;
        b=ejVA3s9u0STvOov1xbNmTPeg7wMMeYTmo/2U/RI0UFoDv/msu37BZxBKmdQFblvKSm
         Z7QOMl7bJCLK1dgPWjlFILlMGduEJ9QQtDmo9o9i5zFj4wR4FPe2RTbkjUw+uT7TV6yi
         qTS6qq8moKHm+rO6eJ+FIyL8/WY4G/g8JUzBljWmnXUsdnTy+Rl/6hlzcJlVhPjTpCHH
         sAhWNw8fSn3Ok40y5qUThqu9xA3XiyUfWYU1BnlH4HPsg7sad0k5PR9WiyEKZdlsmKgq
         axDb6exlK5W5UBqw3Hrd2azAgSjUvSKI5zSD7zAx/doMrPegR3ChDkfHWG+gKPdIpViS
         zj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701776333; x=1702381133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qxXMKWwt2qwPzzAZ0CM5xsYQyZ6d7IRS++BuZ2zfHg=;
        b=hh/ZOl49lfvJpDA5Ig02SwcUq/UkM3s1xNr5HAevCLJllrW1rXMz//YO1UMUDSPHwU
         mGLQMxHwFENG+J0uSsSFde0ZZ/ZX5GweMz4hOf9dUsOLWZoZcedb93/R/GdX9xscCS3A
         HdbJIo9YF+Key7B0taVdAdk6icx2ywuqj5175k/9NfS/C3NXo0Sl2aZsPMZT8L0qYtHm
         XAtglWDjNcDrHiZKbLQEwHymVUsfQMTOlKhDP8DuJy1Lc5PfdPXnOvZTGCKdRuqDjhau
         ZGno9ZhzVB8paWEx5pa2awpDw3JGbsJYGespobptPTWvzGfVtFUrNT8N5kKAtX3StKKg
         0nqA==
X-Gm-Message-State: AOJu0Yx7Zn4dmuzNJe16hK6yh3/RWvX8VyjrfAQznpv+jWql4IZ6hCUj
	WnODOelGhwYj+b0FxY/pFNZHmlsYpH6alg==
X-Google-Smtp-Source: AGHT+IH04sIHQa7UqXwyxQH4Ml2JB3Tbwvaq6P+EjXZfHoq/JEQH4R7JqHSL9Tc2XOUCn4gcn380ng==
X-Received: by 2002:a05:6358:9196:b0:16d:fc28:6ef4 with SMTP id j22-20020a056358919600b0016dfc286ef4mr3492052rwa.25.1701776332996;
        Tue, 05 Dec 2023 03:38:52 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id hq25-20020a056a00681900b0064fd4a6b306sm1350120pfb.76.2023.12.05.03.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:38:52 -0800 (PST)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: djwong@kernel.org,
	bfoster@redhat.com,
	david@fromorbit.com,
	linux-xfs@vger.kernel.org,
	raven@themaw.net,
	rcu@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: About the conflict between XFS inode recycle and VFS rcu-walk
Date: Tue,  5 Dec 2023 19:38:33 +0800
Message-Id: <20231205113833.1187297-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all

I would like to ask if the conflict between xfs inode recycle and vfs rcu-walk
which can lead to null pointer references has been resolved?

I browsed through emails about the following patches and their discussions:
- https://lore.kernel.org/linux-xfs/20220217172518.3842951-2-bfoster@redhat.com/
- https://lore.kernel.org/linux-xfs/20220121142454.1994916-1-bfoster@redhat.com/
- https://lore.kernel.org/linux-xfs/164180589176.86426.501271559065590169.stgit@mickey.themaw.net/

And then came to the conclusion that this problem has not been solved, am I
right? Did I miss some patch that could solve this problem?

According to my understanding, the essence of this problem is that XFS reuses
the inode evicted by VFS, but VFS rcu-walk assumes that this will not happen.
Are there any recommended workarounds until an elegant and efficient solution
can be proposed? After all, causing a crash is extremely unacceptable in a
production environment.

Thank you very much for your advice :)
Jinliang Zheng

