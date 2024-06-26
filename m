Return-Path: <linux-fsdevel+bounces-22543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B38E9198C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 22:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1DF8B21463
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06658192B8E;
	Wed, 26 Jun 2024 20:10:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642FF190686;
	Wed, 26 Jun 2024 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432650; cv=none; b=bgP2XwOZoA3ai/O6NwMPF1qOqA+G40pODOvJafCG5JMsTvgM2sUe0YXts3rXCuemWSy07sKNPyGwrwpncPe2CxLXa8h8IB516E0xGzerZlESpRNLV1+RQ6BIRNkjJJCuIxrsN/nSo78gWzDBHzpnjntG9qzBterJbefIf4qW8Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432650; c=relaxed/simple;
	bh=72ILUG2AaRU+SfnGq1TyfIf48FjZdHLZdxxJtZz1usw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R9OioSSqgMElb/fPBxferp05kqzRYdgJaTARD9zxlsnjEc24QCUMEukwuCM062x2rzPr4c55NHPnUVnV7L78ATYK/IX+EkfTefQcrnep3k2VuY/s3yO+8LJee6fcGfnylXreEVu6DBD2Cfjct5FoqUpeleS8uK90T40DDXpyjqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 034EE2055FA5;
	Thu, 27 Jun 2024 05:10:46 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 45QKAiPP240765
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 05:10:45 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 45QKAivP1261055
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 05:10:44 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 45QKAil51261054;
	Thu, 27 Jun 2024 05:10:44 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH v2 2/2] fat: always use dir_emit_dots and ignore . and
 .. entries
In-Reply-To: <ZnxwEtmYeZcKopJK@quatroqueijos.cascardo.eti.br> (Thadeu Lima de
	Souza Cascardo's message of "Wed, 26 Jun 2024 16:46:26 -0300")
References: <20240625175133.922758-1-cascardo@igalia.com>
	<20240625175133.922758-3-cascardo@igalia.com>
	<871q4kae58.fsf@mail.parknet.co.jp>
	<ZnxwEtmYeZcKopJK@quatroqueijos.cascardo.eti.br>
Date: Thu, 27 Jun 2024 05:10:44 +0900
Message-ID: <87a5j7v517.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

>> Unacceptable to change the correct behavior to broken format. And
>> unlikely break the userspace, however this still has the user visible
>> change of seek pos.
>> 
>> Thanks.
>> 
>
> I agree that if this breaks userspace with a good filesystem or regresses
> in a way that real applications would break, that this needs to be redone.
>
> However, I spent a few hours doing some extra testing (I had already run
> some xfstests that include directory testing) and I failed to find any
> issues with this fix.
>
> If this would break, it would have broken the root directory. In the case
> of a directory including the . and .. entries, the d_off for the .. entry
> will be set for the first non-dot-or-dotdot entry. For ., it will be set as
> 1, which, if used by telldir (or llseek), will emit the .. entry, as
> expected.
>
> For the case where both . and .. are absent, the first real entry will have
> d_off as 2, and it will just work.
>
> So everything seems to work as expected. Do you see any user visible change
> that would break any applications?

First of all, I'm not thinking this is the fix, I'm thinking this as the
workaround of broken formatter (because the windows's fsck also think it
as broken). So very low priority to support.

As said, I also think low chance to break the userspace. However it
changes real offset to pseudo offset. So if userspace saved it to
persistent space, breaks userspace. Unlikely, but I think there is no
value to change the behavior for workaround.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

