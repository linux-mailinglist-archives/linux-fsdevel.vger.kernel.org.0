Return-Path: <linux-fsdevel+bounces-57400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC718B212B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 19:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BFB2A6FA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3712C21EE;
	Mon, 11 Aug 2025 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhq2hFbH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F872C21D7;
	Mon, 11 Aug 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931612; cv=none; b=a9QElHlVMeDCSgxd5MJA8X/lm9Ux4WlSdfXgEJOemZPxtRG49BsfsgOfEGavl+wOHkfJjJmhUjDZbiRUdrCR/8tUyeT/ufRDAlJcOenQMD3lB5uZTLyUYx3WBXjZZlSn2+NQhk0k/RbmieORpu7pTMy2N1GBhZ/JSiXQCoDusiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931612; c=relaxed/simple;
	bh=k9z8ufONhwNETq3bfYfRYPDYJAMQBM2fYTjPqXGH+UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6nR7sylY+gpfk/0F8IN5tQHLw9/97M9KMYyYbfyxXA04mo3IyVLlkmcwqlZ11C+AZAubFgUdPK/sjxODBl6yixin6HPB2ETW3Bawz9ywdwPr8p43rpeNLfagVtEtx+z7XE2kJ2KS9Z+A5kZtoYzf9s+ttiJ0qtRiiYpEtkj+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhq2hFbH; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7075ccb168bso38253296d6.0;
        Mon, 11 Aug 2025 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754931610; x=1755536410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9z8ufONhwNETq3bfYfRYPDYJAMQBM2fYTjPqXGH+UM=;
        b=nhq2hFbH2VeUxeUqeV8l2aRyrrTP7+TmRIyLnp9euY1874P7lmzjIox1ee1M6d9bXv
         v+hoAXA8eksoLm1DzIRVTLu6usfI9kh4Kgt9ebhPUNyyE4u+Eqn8Q97F59rT/oNopBHd
         BZceX97m9neO0BCyUQFDfS0JEp5wn8NwnKBfovQf1WYfDe1fD3HFEAU6ug+0EFSoEsGu
         obIhYv0I/u/Y1gMnYM+ykjCMpMW0IL7k7tg53zXeqScSawLizlILM+1ynBHe1SovbwA5
         WO8v+uAJ5JaBCVQaRycr3PDtqpH6J7GJB4Njonq+f4DCT21O1G7fZKQOEhMPheqYdHX2
         9qEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754931610; x=1755536410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9z8ufONhwNETq3bfYfRYPDYJAMQBM2fYTjPqXGH+UM=;
        b=DB9x3jBVRzBa4YMw0RXDGpq7qU9H1JVbJuWrfcRpL6GJduDlrvJN7vwr+OzpRLFUom
         PlXlsPwH9oeSppnFg85CAgM7swKBZAyY8w4bHC69uRT4SwEbIwEFV1sDYLDCu8b8Tzkg
         kD0AxN10t7MPojS0AuzE5PSod+YkBFcNSl3XtLaz6hZ5LlnWM566qjQYcKQOXeLt6S5F
         ab8B6DN1uFDM57XTJMYSVBpOljj/qxOoLHMcubp2jjbkz66JazOwX+OSovCF4nVpXDVE
         MSuBRH49uIWE2sjaw8YBYOXtVZztVM0HKf8IADiidqcfbw9CagPkaMxyM2bxLtYhPj3b
         /nxw==
X-Forwarded-Encrypted: i=1; AJvYcCU+hADaZPj9697p61BLZeX7IBE7LhD+XoazCitQ8xddeveVOV4XauLAdAlizTzCcxL2gqCH77JZFWaAgNFX@vger.kernel.org, AJvYcCWwgOrmoo87HHSSSZYe4kuvhwTmQTzTWa3ooDDaskEg+tAnh+NRtdcH9Otvtt6l1s9zD9zGtPkn5UVFHi1KRQ==@vger.kernel.org, AJvYcCWzeDuZsnFW4D1QalJkmQ7Pk+b2HaN32Bzto0cVP8bitTY9j4OvuwqUaIo/RJONB2WDErplINQH9/+VIju1FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzl5ucIZiaBYh/wNUzkU/uu8PdKx2O5xWyJ1lSYPuDE+GoYGSu
	sgcNPKTRmGg2KuKMfw4Q2VPlPxTfQg5Y/A1QN3BZTIQGvSzJlh6+eSHi
X-Gm-Gg: ASbGncsDKSpLl16y56haYQ8psBFl4UODxelmEHy2/ZSxrZazmGMp5FU1U3i1PzglIcl
	TqYat1oUeP+YvPCYtMh5KCxz29kuMehib+0XdB9yS9EjAQd68Fp13IMq6uG6aPH0LwugL1x/v4U
	pxGAOerwv5AjtSYwZRhJtYbof6j0eLsaQAAXcoy50obO5a3KN+Eh8fsOBcQ4Ij5fDyoFgU4cSHd
	x9OmSfDs6cuq65Rfkz8Dtx7/vNSRz6UUfLo9dSoD99Cc806HTV7aygKXirTUk9GUKukovzku1K2
	k69OPkQODqcIDstw43OyhmF/v+oP3Nu7JEDeJfZS2JETsS+NjoUr5VyvAkKHwOrrsIYQOgygHpS
	wZQhiwMbK6dE=
X-Google-Smtp-Source: AGHT+IEbIoEUmPYtQXdoxKp5+7KVr57UYJ4gZAVtnzvswzy3kWILO/2M1Q5p58gXAgLvATXXf6/V4Q==
X-Received: by 2002:a05:6214:27ef:b0:709:302a:7aad with SMTP id 6a1803df08f44-7099a2dd887mr153816976d6.24.1754931609413;
        Mon, 11 Aug 2025 10:00:09 -0700 (PDT)
Received: from mambli.lan ([2600:4040:523f:fb00::254c:3ef2])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm158335396d6.70.2025.08.11.10.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:00:08 -0700 (PDT)
From: James Lawrence <jalexanderlawrence@gmail.com>
X-Google-Original-From: James Lawrence <james@egdaemon.com>
To: kent.overstreet@linux.dev
Cc: admin@aquinas.su,
	gbcox@bzb.us,
	jalexanderlawrence@gmail.com,
	josef@toxicpanda.com,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	list-bcachefs@carlthompson.net,
	malte.schroeder@tnxip.de,
	sashal@kernel.org,
	torvalds@linux-foundation.org,
	tytso@mit.edu
Subject: Peanut gallery 2c
Date: Mon, 11 Aug 2025 13:00:07 -0400
Message-ID: <20250811170007.646981-1-james@egdaemon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <ct5pqur2cwn2gulxuu277uomoknflxae32zzpyf4yqbrxcxj4d@p5j77u6xks4l>
References: <ct5pqur2cwn2gulxuu277uomoknflxae32zzpyf4yqbrxcxj4d@p5j77u6xks4l>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fair enough, I was less explicit about which are which. btrfs has mostly a branding issue at this stage, which is fairly rough to dig out of.

You would know better than I would since you're directly in the weeds. I only have prior experiences and old cases to go off, of most of which are out dated at this point, and im primarily interested in raid 5/6 usecases.

Which is why I've mostly stayed out of the lkml drama until now. But removal doesnt resolve the problems with the linux filesystem ecosystem
and it'd be a disservice to everyone to lose convienent access to the work you've done.

crossing my fingers your work will remain,
James Lawrence
Principal Engineer



