Return-Path: <linux-fsdevel+bounces-28350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1E2969BD1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7271C235C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651E31A42BB;
	Tue,  3 Sep 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="HrObXyKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA119C567;
	Tue,  3 Sep 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363084; cv=none; b=ZcyYGT/UnF6XSArKcdklM50ECnx8UeKOuC5bye0f9p6SYRJc1GlLhoVM48dE33QnNxDZdlkVurbPynvIxudckd5S3cLNfxVy7H3WDdY6Hmo4VObxamz2FV8DGXkVLp3Y1k0Cnri33VA8FkGJXmYpBLlpR96BLLtFQdXx2g4hddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363084; c=relaxed/simple;
	bh=necFg49BZLS3ttQXwlqD96uUayV51x+QRMzZsSiB4h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J2OS4FNl8KCnTrQllJtf2lvrSGY7FpXARYxWnrfQXnPbQroGiqNswNHpS3v6aRj3QjSib8MqktOiYG6FO8p2AjlTznIit2K4pOdjtVKESZ38ID+XWr4CsawiMvMeMdyZA4nj62slihaxBlf/rU/ttHaaxfxibU/FLGXZ8eKZJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=HrObXyKc; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id BE85F21D7;
	Tue,  3 Sep 2024 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1725362175;
	bh=necFg49BZLS3ttQXwlqD96uUayV51x+QRMzZsSiB4h8=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=HrObXyKcQN5i3un2liGGPrxPEdym7rV43G84SMIgUWTtTX6EEG8n3sM4M0CJKyVar
	 x69SQvelBUo1aYtmGF+7vm6bqMEWLZsexcrQae9GsfXnCNMmyvJdxkr+Inw53cIgS1
	 0IuViy/86X9aJR4w5u13Ug0RHxFnnnpbxhY2FxNU=
Received: from [192.168.211.161] (192.168.211.161) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 3 Sep 2024 14:24:03 +0300
Message-ID: <06a83e27-407e-48a7-813a-4617ba317307@paragon-software.com>
Date: Tue, 3 Sep 2024 14:24:02 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in attr_make_nonresident
To: syzbot <syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ntfs3@lists.linux.dev>, <syzkaller-bugs@googlegroups.com>
References: <0000000000006ab89d0620ac92fc@google.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <0000000000006ab89d0620ac92fc@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

It's very likely true.

#syz fix: fs/ntfs3: Add missing .dirty_folio in address_space_operations


