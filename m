Return-Path: <linux-fsdevel+bounces-8021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED7282E408
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 00:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6EB5B20D0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F81B7EE;
	Mon, 15 Jan 2024 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clisp.org header.i=@clisp.org header.b="sQONFY2y";
	dkim=permerror (0-bit key) header.d=clisp.org header.i=@clisp.org header.b="5+pBBKfB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA01B7E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=clisp.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=clisp.org
ARC-Seal: i=1; a=rsa-sha256; t=1705361311; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z5K+C6kNxMM8UtSOKoqTVPpijfhK0uvQCGpcA16LzbBQbDsRIFbvMdhYHaGyvnjhS7
    QqH6TeiDyE9TU7TPAwspDAX/sD200SbKVXnohHsiSc+9mxWp+xL6uS0cWH8JsviAYhZm
    jypcWZT6UiG2h1+MSzgvbN4CbeP4mmaVFAXxf7AUJT3Hia4G/fLtmzscJ/itDGWfw2gc
    yAZJYZHh8FqbXoIIECyP/yF7IOdJIW6BL+KLqwGjWeUBV6W9meKd3ujKZDH+2Y1fMpo/
    mX37i8bysFVXiZLAT+q0e5wtUsBr8oPEY5Vbf/97uqflA00LObsn/JA7NS0FATTgziKm
    kHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1705361311;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rOlW0gGBn22ub5RjoWNpKDxKMrNMNo9mtBz2RLK4LKc=;
    b=FXatLu+klnbIGJAKStcpwYaUspKtQkUtfct5PFjbKaKS0Xmhk0Aep/Q6Z2Guft3Fqc
    MDjBThEXjFfBMRVnJ672PBKMv8+Kg19wpgZRnjg9u+LqNcEiBY/Ox9xVBtE4Y1/krBUK
    2DE1rdPnq55DgRu+H0i6Fw8iTevUCfUuvnS2X2qeH2+bjZCjP4WukclzmIkBsLUdMNMN
    fI+IenE4GXNM92S7gLlZtOWD5tvqiLvpQh2wEJk9k6pxXRMyb8G6zsXl76wEMEi/P4oY
    uVzYPtVX0JyYYeD1MSrWWnwhrrUOQuzv1OP2VjEJJz0JetQJpkNBoY/S4roBt0AECEva
    9aLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1705361311;
    s=strato-dkim-0002; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rOlW0gGBn22ub5RjoWNpKDxKMrNMNo9mtBz2RLK4LKc=;
    b=sQONFY2y7+UeIiuuAbJKAiKx1M3IgWYP/r8haiSjBhDlkmrlOezvWqNg2msuznroV2
    9gYIawVYgMR8wsgzb/erRFAP+Wk7hYJsSpKxM9hN9fx06iOLTLXb5l8BAOG+CAJIaeYW
    jUlWEtcUlFcu/tdb+WhfDeSXkwveVWOqHTcutvs9X4uxvVKHCNmMXdS/QTSGY6iIeHZV
    gbVZKmmxHos3vrHq6CjhJqNWjoqr0+6ZY5Ff0ozb9azBYxxPHpUC4ZBXz6vUXUNOGjcw
    zcqEr6B/bcUh9CLYbqRX0Eg0SNGMdJ4qsaBvHpKbOW4JrG2KO3x8+vPpoZmLjfuF7x1U
    RXgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1705361311;
    s=strato-dkim-0003; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rOlW0gGBn22ub5RjoWNpKDxKMrNMNo9mtBz2RLK4LKc=;
    b=5+pBBKfBML+vd4j1fTM5IFeGWgMBIVLSj2wMXhDyYcwp1F3//NQrMPt9MeA4HRgXUy
    SZ9z0ypPq3i7H04G2MAA==
X-RZG-AUTH: ":Ln4Re0+Ic/6oZXR1YgKryK8brlshOcZlIWs+iCP5vnk6shH0WWb0LN8XZoH94zq68+3cfpOSiKRZGkz7dVdJFqfXgrss7axLYw=="
Received: from nimes.localnet
    by smtp.strato.de (RZmta 49.10.2 AUTH)
    with ESMTPSA id c5619e00FNSULQ3
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 16 Jan 2024 00:28:30 +0100 (CET)
From: Bruno Haible <bruno@clisp.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Evgeniy Dushistov <dushistov@mail.ru>, linux-fsdevel@vger.kernel.org
Subject: Re: ufs filesystem cannot mount NetBSD/arm64 partition
Date: Tue, 16 Jan 2024 00:28:30 +0100
Message-ID: <8161983.eFmWaWnqpD@nimes>
In-Reply-To: <20240115223300.GI1674809@ZenIV>
References: <4014963.3daJWjYHZt@nimes> <20240115222220.GH1674809@ZenIV> <20240115223300.GI1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Al Viro asked:
> can NetBSD/i386 mount the same image?

Yes, it mounts fine in
  - NetBSD 9.3/x86_64 (PAGESIZE=4096)
  - NetBSD 8.0/i386 (PAGESIZE=4096)




