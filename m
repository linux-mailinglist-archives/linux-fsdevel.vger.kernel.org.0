Return-Path: <linux-fsdevel+bounces-60253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C888B434CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 09:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88AE04E11A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A892BE029;
	Thu,  4 Sep 2025 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3a7i5P8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3032F775
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972685; cv=none; b=gKne4p6wLAaLghJTdLCQAiRADOeGyIaDKHy2PD81lCJVqn3Wvv3JIpub7lqUK2fDvM68THfUXwqFpttPR8CF6NHDoQAElm7M9DkPh5xUhqqfLzQlVPu2a/Aq3CdDN+8fvxSB4A9hsBeVsQzRdAUM918TNMxBLEpoAiz0veeNcgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972685; c=relaxed/simple;
	bh=+et/Px0MeHwuBXQoXJRlouqlPAO05jR5YhnQ6qXYl+s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TpbOvq7YyxL6QHgqZsgp0ddpYol9pZdb8/5WASf7FI7Dd8n48XNc7HYh7BZhP6QmdpEf8i5vxqSXtW6178xuzpIp31FVRaWOjgSNkhc/MPk+OPcxqd2kk3KzlGn6NAK87PndEZD62Tee34VcamdykSdCDNo/yOBO7uwPXynsdVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3a7i5P8; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d6051afbfso7864307b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756972682; x=1757577482; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+et/Px0MeHwuBXQoXJRlouqlPAO05jR5YhnQ6qXYl+s=;
        b=M3a7i5P8s9AA9wSyspcaOG2dExzrhRPz8UPenb/9ZTlOjvzS1GywMYnCXKJMuacufe
         W3vNCFGyVrvQIo4Eo+kAXSKRsdmjWnOrbhymFwwFdz0Z3GxFmTI0kpxotbuKifsENrh1
         Co1JIKRlDiui5VXOs6KO7PDooqMRh5sbPTnuC6ez7a2pZIxQ0dc1lQFJ5eEIizZLh394
         rrsEBRUvkqRPDPn+fOBBuUs9OWPXE97d9u/8T9XVlv6tKNZiGcN32xNWM1jFCuwzZFX8
         i+6/kpv1Qb9VGW44TwVo8CVNhOauQzr7IknP1I4G6v9xx1RvPrGpMwqZNeCqRgYCEDim
         D3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756972682; x=1757577482;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+et/Px0MeHwuBXQoXJRlouqlPAO05jR5YhnQ6qXYl+s=;
        b=RAgzGWQDw7iWMJxiBfZXf7Yw0pazLg5ZzrQOnniVKhyTsqlDqdBT31b/q7q/UFinng
         s1TDQU97ZSIeJnb4nqZCAKVnbbaIe7d3mMvH5w8hYe5AqohWieg3wR7FgYPLMfoXxOsZ
         Rue7qG3YPrubfL37yuqZzUJyr4GQaGVXm/BpfKPHqKFoiTBm9TVzTHHurlDBGlhzUQzN
         vO1R04ib1ZjqqlyItj/93MWg1ZJ9vMj57wgwL55ccSSzwcU29uLj9Pfy9MG1M0H11WzX
         vqm+R6fWqcZbDIAuBPukhbaij8/N+pbC3BtlHMcvW1+DEgyDROTbZpHfGRMjT2Lrzslu
         w0iw==
X-Gm-Message-State: AOJu0YwFVzqbgjak+WSWni+83A+BPQvOtcU55wZ3yR/sOd8QPGbA211U
	q6VOrX0YVIk4527vH/Xk0k/6fCe7qveRzPBrjbtN66yOBs+kUlIwAAYQyEp4Ws85ouLBgz7Q68d
	FXvAxiZUeOiWXnAiimv8OWlXzsJvjkzPkbWRW
X-Gm-Gg: ASbGncvUcOayIIPXyASCzR84ydsuMQPgIqPZHJUeHwx3nqiSRwdHZwB24s/4y7VlYha
	U1fM5XnQUqxLXXxrUJKOVFUL7RYsUrps531uD36doVCwNu5rB24LkMKfyk+L9s10VEKuMVgvPTz
	BE5Oe/7vztlbuDclin9ku9jAiKgxZgLHsHV5xWw4xwp79YCNDHzeBCCY0cFRyZofEBrha6dtCBC
	Is43aqLkeOPz5rjTMdETyAcakneOoiY9kndGpKqBlrsP+I8
X-Google-Smtp-Source: AGHT+IEKXIhbifexI3LEDL8FPk5lmkVAAlCchN4DO/Gpn5zX07ATaYfOtjm7J5D0n95xgGHgKJ99b2ALV58iADrURrA=
X-Received: by 2002:a05:690c:4441:b0:724:c8b6:18c3 with SMTP id
 00721157ae682-724c8b624bfmr1123247b3.40.1756972682556; Thu, 04 Sep 2025
 00:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vasilis Almpanis <vasilisalmpanis@gmail.com>
Date: Thu, 4 Sep 2025 09:57:50 +0200
X-Gm-Features: Ac12FXzVW4ozX6U894x9BMHCFS_f3OVAbvZYKZxPALC1_ZSITJ50SnbzSHUkpnM
Message-ID: <CALn-KROv-oOBOyujDRnZqZrdRsSHXoCgj=jC3nV=zx=JewKwCw@mail.gmail.com>
Subject: 
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subscribe linux-fsdevel

