Return-Path: <linux-fsdevel+bounces-1606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902797DC42F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 03:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F295B2815CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 02:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EFE10F1;
	Tue, 31 Oct 2023 02:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ADVavCjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11AEC8
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 02:12:02 +0000 (UTC)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 233A5E8;
	Mon, 30 Oct 2023 19:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yaeF0
	1j6xShi/GTkQgI52Gfl0ZCLUkqjv+aPLffFlEc=; b=ADVavCjPJJWDEcu1w1HtR
	wBLQUHB/Nvy4eUgKX4lXSMCFaj8L6ztsGZAz535ybwB+v26FMMjE3ClmqnN07vHz
	kR0YHun62E8bn2R2MRXZMeCZn1Y89NyIIemzYqW4vAU8IpgE7hKNuK9/tY0iKdmm
	W4OuZ8dmAcl4SOqGrW4eRw=
Received: from localhost.localdomain (unknown [106.13.245.201])
	by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3X9NSYkBlDPrVAA--.35827S2;
	Tue, 31 Oct 2023 10:11:39 +0800 (CST)
From: Yusong Gao <a869920004@163.com>
To: brauner@kernel.org
Cc: a869920004@163.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [RESEND PATCH] fs: Fix typo in access_override_creds()
Date: Tue, 31 Oct 2023 02:11:30 +0000
Message-Id: <20231031021130.855308-1-a869920004@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030-debatten-nachrangig-f58abcdac530@brauner>
References: <20231030-debatten-nachrangig-f58abcdac530@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X9NSYkBlDPrVAA--.35827S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF4rJr47Kr4kJF18GFykKrg_yoWkKrc_ur
	40yr4xCrs8JFy0vwn09an0yF1Sg3yrAF18AFn7JrsI9r93Aas5ur98Kr93t398WF4xKr98
	Jrn5ZF9rZr4IvjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMYLv7UUUUU==
X-Originating-IP: [106.13.245.201]
X-CM-SenderInfo: zdywmmasqqiki6rwjhhfrp/xtbB0x8a6VXl17rCFAAAs0

At 2023-10-30 16:32:37, "Christian Brauner" <brauner@kernel.org> wrote:
>On Mon, Oct 30, 2023 at 01:52:35AM +0000, gaoyusong wrote:
>> From: Yusong Gao <a869920004@163.com>
>> 
>> Fix typo in access_override_creds(), modify non-RCY to non-RCU.
>> 
>> Signed-off-by: gaoyusong <a869920004@163.com>
>> ---
>>  fs/open.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/open.c b/fs/open.c
>> index 98f6601fbac6..72eb20a8256a 100644
>> --- a/fs/open.c
>> +++ b/fs/open.c
>> @@ -442,7 +442,7 @@ static const struct cred *access_override_creds(void)
>>  	 * 'get_current_cred()' function), that will clear the
>>  	 * non_rcu field, because now that other user may be
>>  	 * expecting RCU freeing. But normal thread-synchronous
>> -	 * cred accesses will keep things non-RCY.
>> +	 * cred accesses will keep things non-RCU.
>
>I think this might have been intended as a joke aka "non-RCY" as in
>"non-racy" here. I think best would be to change it to something like
>"cred accesses will keep things non-racy and allows to avoid rcu freeing"
>if you care enough.

I see what you mean. Thanks for your reply. I don't think any more
changes are needed when I figure out it.


