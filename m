Return-Path: <linux-fsdevel+bounces-32376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DA39A4764
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 21:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960A12879BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 19:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D47205E17;
	Fri, 18 Oct 2024 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="e9AlYhZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984FD20262E;
	Fri, 18 Oct 2024 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280901; cv=none; b=kdpLOZrlysEgXetDRLO2jKbbMT0qPMCS82hacVnUteLG7CUGmdS8VxU1fA0dyhbt02RdIrXsTTG8YfUlwr+QuSaZn6IbjiRavghyXzcSWicpXRCFdZ+mbI2Vo8KcjbkH6jBDYJhE5rEfzsu3nW43L0FNii83Al4RnzOawJJFT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280901; c=relaxed/simple;
	bh=Ryh9S2w/8zyf3l/+bRpDuNkHuLoaWcsDvh6MES496PE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zvl19tT5WSmv2Ue5Y5+CDzIbm+Phxq1/3Dl1OeW/JBgABsCQft8XII1iCcDTP9G8lwCgvullvJXGPRwGbSDLbbr6EVhgK3e8yEbTpqjJmhxEQuRzFJua4qSBZqwlS7ZDE3WUBk/hjdOy1DHDHCpCOY84xbxWPoLg0A4y80r/j0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=e9AlYhZV; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 336E1E0003;
	Fri, 18 Oct 2024 19:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1729280891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5bo6tysJTyx2Rxxt6aYaCsgvYERLIISBXrIf2OzQFeo=;
	b=e9AlYhZVsNZ9Nztvev4a4MOSxn3Gj6Az753LsSsJJDifeHimwu9Vv6vQJbaKLbRdejixbt
	+PqAB8DlqCAaj/j9KFbPdMKu8dqKhgNoxpM49so3Vdyweg9DGotN767mFr/QI1UmPQp0Hl
	WH+1AyzUy1qK1tS0bIWk6MdBZ6SR101VRmyBQOJ9lLkN6YXKZg8m4BdAgR/LqJ7bElgopK
	s+lxI2hMS5T/gAMnxeLB6eMsRcjbfCvP6fJ/yLiXBjyawGWwOSFX1vky7vugZMoaDAsqw1
	pFqwNcIh3uNUIetMd3LmpFeqKUKUEhKqNXBSJ6MkDr22wyboFAiJGrwCslvZ7Q==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger.kernel@dilger.ca>,  Hugh Dickins
 <hughd@google.com>,  Andrew Morton <akpm@linux-foundation.org>,  Jonathan
 Corbet <corbet@lwn.net>,  smcv@collabora.com,  kernel-dev@igalia.com,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-ext4@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 0/9] tmpfs: Add case-insensitive support for tmpfs
In-Reply-To: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Thu, 17 Oct 2024 18:14:10 -0300")
References: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
Date: Fri, 18 Oct 2024 15:48:07 -0400
Message-ID: <87frotyyyw.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> Hi,
>
> This patchset adds support for case-insensitive file names lookups in
> tmpfs. The main difference from other casefold filesystems is that tmpfs
> has no information on disk, just on RAM, so we can't use mkfs to create a
> case-insensitive tmpfs.  For this implementation, I opted to have a mount
> option for casefolding. The rest of the patchset follows a similar approa=
ch
> as ext4 and f2fs.

Hi Andr=C3=A9,

The series looks good to me now. Thanks for the changes.  Let's see what
others think.

--=20
Gabriel Krisman Bertazi

