Return-Path: <linux-fsdevel+bounces-63803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CEDBCE632
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 21:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCBF19A802F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2671301498;
	Fri, 10 Oct 2025 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="AW+nKmSB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10C214A97;
	Fri, 10 Oct 2025 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124480; cv=none; b=E0tkFTBASlmIL2lPgB8JX/9jYJTcfsTplqzakFKUUjaNt7ZS+ZZlnB/zlcREBiK/Csd6g7km6sRmCqPvbRZrfZ+IeE5yLSh4rOCOT3qvZbxcIjAbYJWgcUtImvZzLpWUe9QamH6VZvbHcXN0+PIjXSdjA/sFdhUvvtEreHz27s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124480; c=relaxed/simple;
	bh=BKU1mOrngwnrQel8ySNAeHt9ItbwwpG5di7ynGcs5zY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZYXReZd0Y+oVtlDv4ZadjDJdTiY3AFCe4uK1b8S/GvMorhPuywRKElelU+YIruHjYa3o9zAyMMhlvqsql1kD5V8kDB1Zr3r8pX85u3hRLjyLEiIOg7R72zJB4BiUhuZOYDYkaoRpvuNv2HcI4STAVYWKWouXV5mxfpFiAgpkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=AW+nKmSB; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 37A075816E6;
	Fri, 10 Oct 2025 19:06:17 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2408B443A9;
	Fri, 10 Oct 2025 19:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1760123169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RT3I+Aw6mgBFFUKrYHKkLH1uNNtDDVJOkY8Er1mJ2dI=;
	b=AW+nKmSBAg080I8SZECBBCTIBOkqgAFBpREokJPVqstRKpIW+knsCVD9nu6uniokQzWgGF
	o0hAkuWwvRMxPqP4A+nnDOWM/2msG7BhAsb90F2iYDdDjwUYNdJJxkHmolCXAq2o5JF7Wu
	0DuSSQ08noPa0G3Dz55RmYrdWQ26tejzJTnPdW9eVkA0iuFK4dxv4V28U095zOSGok/W7U
	SCaZ9xux0jKZyXizY3kizbhd9PtuUpkHHGAZn/bYoQsfdsfZoNXcaEfJ+fH2ro0SGz/nmc
	yLG24GDHZVP/F43zva06E2bvJ3utY9suU80qNSMzlLPzlAhICtP2j2AqRt5vNg==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,  Chuck Lever <cel@kernel.org>,
  Amir Goldstein <amir73il@gmail.com>,  linux-fsdevel@vger.kernel.org,
  linux-nfs@vger.kernel.org,  Chuck Lever <chuck.lever@oracle.com>,  Jeff
 Layton <jlayton@kernel.org>,  Volker Lendecke <Volker.Lendecke@sernet.de>,
  CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
In-Reply-To: <20251010144938.GB6174@frogsfrogsfrogs> (Darrick J. Wong's
	message of "Fri, 10 Oct 2025 07:49:38 -0700")
References: <20250925151140.57548-1-cel@kernel.org>
	<CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
	<87tt0gqa8f.fsf@mailhost.krisman.be>
	<28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org>
	<87plb3ra1z.fsf@mailhost.krisman.be>
	<4a31ae5c-ddb2-40ae-ae8d-747479da69e3@kernel.org>
	<87ldlrr8k3.fsf@mailhost.krisman.be>
	<20251006-zypressen-paarmal-4167375db973@brauner>
	<87zfa2pr4n.fsf@mailhost.krisman.be>
	<20251010-rodeln-meilenstein-0ebf47663d35@brauner>
	<20251010144938.GB6174@frogsfrogsfrogs>
Date: Fri, 10 Oct 2025 15:06:05 -0400
Message-ID: <87v7kmziea.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gabriel@krisman.be

"Darrick J. Wong" <djwong@kernel.org> writes:

> n00b question here: Can you enable (or disable) casefolding and the
> folding scheme used?  My guess is that one ought to be able to do that
> either (a) on an empty directory or (b) by reindexing the entire
> directory if the filesystem supports that kind of thing?  But hey, it's
> not like xfs supports any of that. ;)

We only support enabling/disabling on an empty directory.

Disabling casefolding on an already populated directory would be easier
to do - just re-index, as you said.  But to enable it, you'd need to
handle cases where you have two different files that now have the "same"
name (differing only by case). Then, which one you'll get is quite
unpredictable (perhaps, the order the dirent appears on-disk, etc).

So we just don't allow it.

-- 
Gabriel Krisman Bertazi

