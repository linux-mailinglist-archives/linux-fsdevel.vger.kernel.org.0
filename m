Return-Path: <linux-fsdevel+bounces-14267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5E987A3E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 09:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAA2283176
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 08:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E483175BF;
	Wed, 13 Mar 2024 08:05:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2691FAA;
	Wed, 13 Mar 2024 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317152; cv=none; b=QzsDDWbArXr8GZLbD0WGy1Y/799Uw47jMBTZpOEW3x/VlDhqkI1vZCwRrrlHfcX9g70hOgXeyP+HGwRhUbn3CyFS2/WTnIWwke8FzU5K4+0fvmEF+dmZzXNJxRHQhd9UFKDfwPmWvPG/jsmQvebUeI8NqEtaC/rNA4wbrw0bBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317152; c=relaxed/simple;
	bh=iGUTOChP2qLNuIgaeQzdWxJUJNfblPaVfAPZRVbOzbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ngvz52RWsIAGqVI/a70jkDJpqmGK+XujFA6Y1i2Bt99zIySnJQn317SkWRuFfdW3qB2QNBzvoq6F3BFeOqh40JS4miaQQQNqfNuq9R+DXOjXw2R7kXLFPpM+yIVJHJ6qogYNQcg0s/yUbD6tkTqftU42Aaf+Dtx1tr2/z/jxpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 7601B205DB9A;
	Wed, 13 Mar 2024 17:05:43 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42D85gQJ214984
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 17:05:43 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42D85ggS1292805
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 17:05:42 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 42D85fDF1292804;
	Wed, 13 Mar 2024 17:05:41 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
In-Reply-To: <ZfFcpWRWdnWmtebd@quatroqueijos.cascardo.eti.br> (Thadeu Lima de
	Souza Cascardo's message of "Wed, 13 Mar 2024 04:58:29 -0300")
References: <874jdzpov7.fsf@mail.parknet.co.jp>
	<87zfvroa1c.fsf@mail.parknet.co.jp>
	<ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
	<87v86fnz2o.fsf@mail.parknet.co.jp>
	<Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
	<87le75s1fg.fsf@mail.parknet.co.jp>
	<Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br>
	<87h6hek50l.fsf@mail.parknet.co.jp>
	<Ze2IAnSX7lr1fZML@quatroqueijos.cascardo.eti.br>
	<87cys2jfop.fsf@mail.parknet.co.jp>
	<ZfFcpWRWdnWmtebd@quatroqueijos.cascardo.eti.br>
Date: Wed, 13 Mar 2024 17:05:41 +0900
Message-ID: <878r2mk14a.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

>> You are forgetting to count about normal dirs other than "." and ".."?
>> 
>
> Yes, I was not counting those. The patch simply ignores ".." when counting dirs
> (which is used only for determining the number of links), and always adds one
> link. Then, when validating the inode, it also only requires that at least one
> link exists instead of two.

So you break the mkdir/rmdir link counting, isn't it?

Thanks.

> There is only one other instance of fat_subdirs being called and that's when
> the root dir link count is determined. I left that one unchanged, as usually
> "." and ".." does not exist there and we always add two links there.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

