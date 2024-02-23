Return-Path: <linux-fsdevel+bounces-12561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9448D86117C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54CD1C2203B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 12:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F97CF2D;
	Fri, 23 Feb 2024 12:29:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440407C6D4;
	Fri, 23 Feb 2024 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691382; cv=none; b=F2Wc3PVEzHaI3Ke487I0/UpHrpdoJxTwsJOowfkxF2qCsqrD6asVEk/3lcqnDNCzeTKsn+WWZhMj56tPYy6lJLUZOpriw7YrSY0Sdb4wcbQpcyIBmIk73NMOx6wRqIMItbPFQ+frVXJjhSiw39zdb3wn5r0EpHPSJLFwVBymsr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691382; c=relaxed/simple;
	bh=iyxOs3Eo4svT/sfgTsn046sBzxstqQpSb2db9fzbEGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Veo/8QdM3xc/7qvB0lPcfLvfzY3zrd16LHvJY9a7mhUB6XOXnfO6PUy+8L9J70rpMP1lDFE5zoernxmJmcAEIppZ+8lzbmJm5+cON3qzZ02l42ITostgLu+Eopn+qbYhqT0ux9edolR1wgkj8qo9XVMnmBnKDlaf/ESnGTVzZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id CE8FF233CCB7;
	Fri, 23 Feb 2024 21:29:37 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 41NCTaYb217639
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 21:29:37 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 41NCTau81066976
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 21:29:36 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 41NCTZmW1066975;
	Fri, 23 Feb 2024 21:29:35 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
In-Reply-To: <ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br> (Thadeu Lima de
	Souza Cascardo's message of "Fri, 23 Feb 2024 06:58:56 -0300")
References: <20240222203013.2649457-1-cascardo@igalia.com>
	<87bk88oskz.fsf@mail.parknet.co.jp>
	<Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
	<874jdzpov7.fsf@mail.parknet.co.jp>
	<87zfvroa1c.fsf@mail.parknet.co.jp>
	<ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
Date: Fri, 23 Feb 2024 21:29:35 +0900
Message-ID: <87v86fnz2o.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

> So far, I have only seen expected correct behavior here: mkdir/rmdir inside the
> "bogus" directory works. rmdir of the "bogus" directory works.
>
> The only idiosyncrasies I can think of is that if neither "." or ".." are
> present, the directory will have a link of 1, instead of 2. And when listing
> the directory, those entries will not show up.
>
> Do you expect any of these to be corrected? It will require a more convoluted
> change.
>
> Right now, I think accepting the idiosyncratic behavior for the bogus
> filesystems is fine, as long as the correct filesystems continue to behave as
> before. Which seems to be the case here as far as my testing has shown.

There are many corrupted images, and attacks. Allowing too wide is
danger for fs.

BTW, this image works and pass fsck on windows? When I quickly tested
ev3fs.zip (https://github.com/microsoft/pxt-ev3/issues/980) on windows
on qemu, it didn't seem recognized as FAT. I can wrongly tested though.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

