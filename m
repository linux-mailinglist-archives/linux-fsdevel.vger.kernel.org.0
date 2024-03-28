Return-Path: <linux-fsdevel+bounces-15516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5E788FD79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 11:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF84B21C6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 10:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208927D412;
	Thu, 28 Mar 2024 10:54:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973054C62E;
	Thu, 28 Mar 2024 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623246; cv=none; b=PmSF7i1Zmrzfir/+WP6YWFx91Y7GCdbpsZ4TxEpR1ZpAmBLfdR3o8uZ+rYg/7m92hrCAgSegyvIIppel/52n17T7PE5y0KBS2cSlo1G7kzUkA9WHLTj0CxmePn8Ch24PJCZcSBxNKrdrHNTg4/zAs9lDpZeVGOy2oOnLk9kl7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623246; c=relaxed/simple;
	bh=YQRBwIKyXMFpVXmOargCtb2gMHL7sG7XI5XG2RQxFsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1xsb2B5fuvSVeM/WLEdVV0vu79eygLpMRqdLHfc4EVmZ5IatG8aEboWshAfC5rzhka+tu5FoJbtQpi6lMMOeYGrISVCx1ppW2dxH8zAmHCWRChOeI/3BLLVu2GGji/fPdpMGGTHOtPv6Vtq1YYPZPIW1HRqqvxra2ZNkLbuW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4V50Nw6SYJz9xqx4;
	Thu, 28 Mar 2024 18:37:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 3F8F2140417;
	Thu, 28 Mar 2024 18:53:55 +0800 (CST)
Received: from [10.81.200.225] (unknown [10.81.200.225])
	by APP2 (Coremail) with SMTP id GxC2BwAnEyc4TAVmFhodBQ--.8703S2;
	Thu, 28 Mar 2024 11:53:54 +0100 (CET)
Message-ID: <4a0b28ba-be57-4443-b91e-1a744a0feabf@huaweicloud.com>
Date: Thu, 28 Mar 2024 12:53:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel crash in mknod
To: Christian Brauner <brauner@kernel.org>,
 Roberto Sassu <roberto.sassu@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Christian Brauner <christian@brauner.io>, Mimi Zohar <zohar@linux.ibm.com>,
 Paul Moore <paul@paul-moore.com>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV> <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
 <cb267d1c7988460094dbe19d1e7bcece@huawei.com>
 <20240326-halbkreis-wegstecken-8d5886e54d28@brauner>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <20240326-halbkreis-wegstecken-8d5886e54d28@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAnEyc4TAVmFhodBQ--.8703S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1rZw48CryDurW8GFy8Zrb_yoWkArc_Cr
	s0ya4UG3y7ur93AF47WF1SgrZxAFWagry7CrWkKFy7t34DJrs8JFZ0vr93Wr1UWFWfGFnI
	kryDAa40kry2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBF1jj5vkfAAAsn

On 3/26/2024 12:40 PM, Christian Brauner wrote:
>> we can change the parameter of security_path_post_mknod() from
>> dentry to inode?
> 
> If all current callers only operate on the inode then it seems the best
> to only pass the inode. If there's some reason someone later needs a
> dentry the hook can always be changed.

Ok, so the crash is likely caused by:

void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry 
*dentry)
{
         if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))

I guess we can also simply check if there is an inode attached to the 
dentry, to minimize the changes. I can do both.

More technical question, do I need to do extra checks on the dentry 
before calling security_path_post_mknod()?

Thanks

Roberto

> For bigger changes it's also worthwhile if the object that's passed down
> into the hook-based LSM layer is as specific as possible. If someone
> does a change that affects lifetime rules of mounts then any hook that
> takes a struct path argument that's unused means going through each LSM
> that implements the hook only to find out it's not actually used.
> Similar for dentry vs inode imho.


