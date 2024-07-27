Return-Path: <linux-fsdevel+bounces-24360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C982293DDA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 09:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AD41F223C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 07:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617A51B86C2;
	Sat, 27 Jul 2024 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b="cgAwlTeA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034D282EE
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2024 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722064927; cv=none; b=uVU5m0cnETWpOynD5cHH6bI7XiI7fS/pRQ7QKoguCR3zwgR2Eh45Oh3vEGEBpW4njbU40KTr6giFKF08RJxjNbTLMDYtZOpbCXRnHvbIu8P4JDe4vad2djkT037ljcD0tvEovv1yRJdkoOoLaSXvcqrQ8Wvs1h965lJOyXvXdhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722064927; c=relaxed/simple;
	bh=vzIBUEToGq/rg33KRZqUbS+BZo+vr87Uh3U+ngv0nxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Orb6HU+GIGUUChVhJe39BY6nybqrffhKLzMKO8Oz/lGcrZ0CKlw2y8txSsvSAs7HSIb+YTcWsnAX47BlL7fAGfTPx/ABy8Oi1CAlKsFD/MdAvF1rxhTss/RPAI8qWKugLPv1k8oN0Nsf4afTkTR7DpX4wxNoPAzpcgwJO7S888c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in; spf=fail smtp.mailfrom=mitaoe.ac.in; dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b=cgAwlTeA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mitaoe.ac.in
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso1305309a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2024 00:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mitaoe.ac.in; s=google; t=1722064924; x=1722669724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vzIBUEToGq/rg33KRZqUbS+BZo+vr87Uh3U+ngv0nxY=;
        b=cgAwlTeAouwmAEyUjvaLlNszhhauusGUfIFUXlmwbY39d1HhBzrj/YqjEa+Q7XwBBc
         HdgKRQahGw7JY3vYGjrG090SSAJ94KvqtC0rCGeqU4WJsurkgQIou/kqFJwocxpCZXAn
         SrXEWhWKrxgUC2XFK49/YE3gdZ35xy7Ncz1xCImxTVRBcbIOet93gj1bsMjeqhXOSoE7
         f7OXzrTuoQ3Bpxq+VLz0p2pegHLofJdbC+WdPgRZuxBddAb6YMfGgBnIuIEBTkTZL2VM
         Gps29hjaKzZ7dkdF2y1Jlvq1yodxHWLovLLVa5Fb7GX0q6RSC5CqJL/m2XT1BHcUJyWz
         0EYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722064924; x=1722669724;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzIBUEToGq/rg33KRZqUbS+BZo+vr87Uh3U+ngv0nxY=;
        b=w/UVv4cZeejlsLThD4wUPXXdFt5r2xJNbNJ5UavfOE0sqJWzSYLuZ1MoyqnmdrWRWD
         U3qliPZ1RScQ/jJiflH26kPM8vukbJxO+3WQqCUwEKFmTghtIcs/2nIV956J35Zeos9e
         xiPLiOIFsx/l7CgC31TXRowDbnz/Ijz4JT6o+tlQ1CueWTfihzvxwrKgZNSCq3DIAgHf
         AmI//cttVphZz30VOsbHeqRYt0lR4DWLM3nb7TYHXcNrw5SbEYimFh34amrSU5lktUNq
         nTSPTlmMJ508Qm65o78/m7tIYaZydMbFX3qwAfXZPSwHKfvY9HvPdy1wGNSdCuYF+53N
         eEYw==
X-Forwarded-Encrypted: i=1; AJvYcCWtP1qeyX2ALT/zrFysfV6giSU5c4ID9s2kP7KnvezJLmGYvPfP/XrWfXLyb8Z+pckZWlq4Dq/wV4c1BM3X6CXd5kO8eRoGDU+rcTcFeQ==
X-Gm-Message-State: AOJu0YwsP+S+SgM2PhIQVGaDpSH+T9YAjECfPh0n9hT1C12t0nOOlkcx
	PhXd/7KDNPnU7WTyqndih6vA7UkzFXVPezV7fzaN0Dh1abvI5mtWGJ7v/AJKokCwAKYITa41A3Q
	Wpl4=
X-Google-Smtp-Source: AGHT+IFczpc3FZ0FglqXNLJYRYQU7w8MjWdAByQrR/3N/RxSEsot5zMll4v5JvehTrzeRMwzFMqKBQ==
X-Received: by 2002:a17:90b:4a04:b0:2c5:32c3:a777 with SMTP id 98e67ed59e1d1-2cf7e5f5ddemr1921643a91.28.1722064924579;
        Sat, 27 Jul 2024 00:22:04 -0700 (PDT)
Received: from localhost.localdomain ([152.58.18.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb74e8769sm6634537a91.42.2024.07.27.00.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 00:22:03 -0700 (PDT)
From: mohitpawar@mitaoe.ac.in
To: brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [Patch] Fixed-fs-file_table_c-Missing-blank-line-warnings-an.patch
Date: Sat, 27 Jul 2024 12:51:33 +0530
Message-Id: <20240727072134.130962-1-mohitpawar@mitaoe.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <linux-fsdevel@vger.kernel.org>
References: <linux-fsdevel@vger.kernel.org>
Reply-To: brauner@kernel.org jack@suse.cz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit



Thank You Jan and Christain for your support!!

I have added the Signed-off-by tag and updated the struct file declaration.

Regards,
Mohit


