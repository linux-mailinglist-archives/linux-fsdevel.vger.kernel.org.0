Return-Path: <linux-fsdevel+bounces-34436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1B69C56AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 12:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C80286049
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C6E1FA834;
	Tue, 12 Nov 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN5K80uU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9151FA829;
	Tue, 12 Nov 2024 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411216; cv=none; b=j1Ng2osu4C+uEo6bXZ2pFcH0u6NxSgXOQcn7kR/K03jxahkJmEyoxoGqTHTB9k+Dh+EqV8fPnG4aaNq+q2Yy7BjZ5LBMe74VnblzWyUgKyJJQmynboomTi71ZuY4DlaPdyDlX73ZbhLk0LdrGJ+CzEP1AT/0IPVTUTTYkxctcvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411216; c=relaxed/simple;
	bh=0cTRMGq4PvxOsMufA4/GtzkLhnhb5AUmZdtV9AfXvEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WX8eJXdyoufYlVC+5loAa695nC1zE9an8lglFB0J3/ddCmjMIXZ2lQROSFMWnlSrGrZX3oXIsS1BoLA8ZAvU9S06VqHq7fi/3EkCNuKi5K3zXROD/SCmaaYH6rIGu68pjWq4fZPDHZHKomE9U1pBYz4fDHDj7EykQglcsOHtkPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EN5K80uU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7eda47b7343so3671729a12.0;
        Tue, 12 Nov 2024 03:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731411214; x=1732016014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cTRMGq4PvxOsMufA4/GtzkLhnhb5AUmZdtV9AfXvEw=;
        b=EN5K80uUTuQqjXoE5xNeGHrgc4jWShbqNwPKVPheVbkOf76ZQlvwBgI6j3ilmSj40f
         AeR3VHR/u5bZbqZYIVm2K8kf3AmF0ji6qmNDz9j8dkns/1EOQMB6wpolHlBNWoc6GVUY
         WgSV+DKf7x6RWbCctTm7RXhMfKhRyIlq/LsrYegmGyVWcREVXTc+lRbG3chWvZtAiy5w
         tM6XMbmj4bEkR15LbGPlLHdsDbU9GaDOUlRYDmKqDnf57mSjBCAkFfJwpdmUOZGq4wKD
         I0TWjYY+GElkPJ46PMiv2WxCzdRqo/TxDd2qgk5dhB0ecxmi4207TSIjoB+DvLtFfKfE
         O0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731411214; x=1732016014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cTRMGq4PvxOsMufA4/GtzkLhnhb5AUmZdtV9AfXvEw=;
        b=DjoL6HEpfCpI4z1rUMnZgVS/zX1HIJxJCgom+sHXYO4Io13jBvftk9rbEKYMl8nu9v
         RZsZBVpDchQ9Kaqn/5247Xl19Tp3K+alCDZ3mZAa6qkZQqblSHfEqLWlTtH+bRyApY75
         XeS+YpurvwxU9tQrQlLfQaW5yRI00tnmiRSBtZIZDgLLmBf8jc3Kh4MSS5w/ubdWpgz+
         6B0qdRlWsCbKdqfG1XE3758Ycvt8KEdzdzoeM8at+6oWxmikWGqldmeXLniIx1pKjN6E
         ft0dTkKPG79SZNbYAChrhp/lhI+TiI5KBewHAhGgvDnhhn+ofl4btY1H6T+PITBX7T60
         6qPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR/Ebr5YMlBeLfXie3fNAoe2nwTig5NugWtg5Fq+lGktPV3le3G2mEjFUva+uCQhzrN36lQlzpUP12/cLl@vger.kernel.org, AJvYcCXCnQ3899obNcKXG5OS+aMdEqwNOrmDDg+yOlKeWPEQzggtbI7xmkiFWOZ/8mtiqcnx69to1GAMcP0N8PqH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3lnP5xge+w7QM+SW/UUaKHdBqGXrJG0JJo7XJpq8qyCNMybL3
	/Z9c5gsN53zmxTbZwFY4coRIQ6uN2L8o+HkT35THbVwfzE96D5ap
X-Google-Smtp-Source: AGHT+IH1oCFtVEm/b1ekJPmZR1NOPwDWkuAJQgs5hXFHMS2yGdkHgDvcNeyNuQbRYynsblFObu8jOA==
X-Received: by 2002:a05:6a21:1690:b0:1d9:aa1:23e3 with SMTP id adf61e73a8af0-1dc22b664d3mr25161875637.32.1731411214184;
        Tue, 12 Nov 2024 03:33:34 -0800 (PST)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72407a1af57sm10942244b3a.161.2024.11.12.03.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:33:33 -0800 (PST)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: jmoyer@redhat.com
Cc: bcrl@kvack.org,
	brauner@kernel.org,
	jack@suse.cz,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pvmohammedanees2003@gmail.com,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH] fs: aio: Transition from Linked List to Hash Table for Active Request Management in AIO
Date: Tue, 12 Nov 2024 17:03:24 +0530
Message-ID: <20241112113324.15544-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <x49ed3hrab9.fsf@segfault.usersys.redhat.com>
References: <x49ed3hrab9.fsf@segfault.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> A new patch would make more sense.

Absolutely, I'll do that.

Thanks!

