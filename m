Return-Path: <linux-fsdevel+bounces-63660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7CBBC925B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 14:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52C0E4F3B18
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 12:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541342E62DC;
	Thu,  9 Oct 2025 12:58:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F833D8;
	Thu,  9 Oct 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014701; cv=none; b=ALeczyKujUoz+uNADWpko1aLg8OZIEeHpyiIcPW8hty5y0hYFG/Whz7Mdcffk7U386p3NwtzEReX/VtjBOGpwWh+qoOjNXbOK+cf1geEz1wu8ZWoccUllbS2GNRzNjRYzEIFjt+TT7T//Zl2XRTPy3uS47YuWlzzZVWXkT5rBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014701; c=relaxed/simple;
	bh=LoaVQodVhFo56YznmyVF9NYQySEKHXOiB5FSKqVj0xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWUL4Y+3TfNSNvCkmz948WSMLtuBgK4nEShR51XO5wXKS3f4E9t499QYKHRkhW4WAbU7/CEmQsTMv6TLF698fffUC6M4+2m7Ak6R2JCMlbSSGsYBZ8vK6W6/8Hqdwn9ic9dRL1CFkcP9Z2IPm1OHtPbqrUaKwxHxc/9ld2j4cuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 599CvacV010883;
	Thu, 9 Oct 2025 21:57:37 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 599CvaUs010879
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 9 Oct 2025 21:57:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <559c331f-4838-49fb-95aa-2d1498c8a41e@I-love.SAKURA.ne.jp>
Date: Thu, 9 Oct 2025 21:57:33 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: Validate CNIDs in hfs_read_inode
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        George Anthony Vernon <contact@gvernon.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linux.dev"
 <linux-kernel-mentees@lists.linux.dev>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
 <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251003024544.477462-1-contact@gvernon.com>
 <405569eb2e0ec4ce2afa9c331eb791941d0cf726.camel@ibm.com>
 <aOB3fME3Q4GfXu0O@Bertha>
 <6ec98658418f12b85e5161d28a59c48a68388b76.camel@dubeyko.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <6ec98658418f12b85e5161d28a59c48a68388b76.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp
X-Virus-Status: clean

I found this patch. Please CC: me when posting V2.

On 2025/10/07 22:40, Viacheslav Dubeyko wrote:
> On Sat, 2025-10-04 at 02:25 +0100, George Anthony Vernon wrote:
>> On Fri, Oct 03, 2025 at 10:40:16PM +0000, Viacheslav Dubeyko wrote:
>>> Let's pay respect to previous efforts. I am suggesting to add this
>>> line:
>>>
>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>
>>> Are you OK with it?
>> I agree with paying respect to Tetsuo. The kernel docs indicate that
>> the SoB tag
>> isn't used like that. Would the Suggested-by: tag be more
>> appropriate?
>>

I'm not suggesting this change. Therefore, Cc: might match.

But I don't like

  Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com

line, for syzbot only tested one cnid which was embedded in the
reproducer. My modified reproducer which tests all range still hits
BUG() when the inode number of the record retrieved as a result of
hfs_cat_find_brec(HFS_ROOT_CNID) is HFS_POR_CNID. That is why I push
https://lkml.kernel.org/r/427fcb57-8424-4e52-9f21-7041b2c4ae5b@I-love.SAKURA.ne.jp
as a fix for this problem (and you can propose this patch as a
further sanity check). Unless

>>>
>>>> +{
>>>> +	if (likely(cnid >= HFS_FIRSTUSER_CNID))
>>>> +		return true;
>>>> +
>>>> +	switch (cnid) {
>>>> +	case HFS_POR_CNID:

we disable HFS_POR_CNID case (which I guess it is wrong to do so),
we shall hit BUG() in hfs_write_inode().

>>>> +	case HFS_ROOT_CNID:
>>>> +		return type == HFS_CDR_DIR;
>>>> +	case HFS_EXT_CNID:
>>>> +	case HFS_CAT_CNID:
>>>> +	case HFS_BAD_CNID:
>>>> +	case HFS_EXCH_CNID:
>>>> +		return type == HFS_CDR_FIL;
>>>> +	default:
>>>> +		return false;
>>>



>>> int hfs_write_inode(struct inode *inode, struct writeback_control
>>> *wbc)
>>> {
>>> 	struct inode *main_inode = inode;
>>> 	struct hfs_find_data fd;
>>> 	hfs_cat_rec rec;
>>> 	int res;
>>>
>>> 	hfs_dbg("ino %lu\n", inode->i_ino);
>>> 	res = hfs_ext_write_extent(inode);
>>> 	if (res)
>>> 		return res;
>>>
>>> 	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
>>> 		switch (inode->i_ino) {
>>> 		case HFS_ROOT_CNID:
>>> 			break;
>>> 		case HFS_EXT_CNID:
>>> 			hfs_btree_write(HFS_SB(inode->i_sb)-
>>>> ext_tree);
>>> 			return 0;
>>> 		case HFS_CAT_CNID:
>>> 			hfs_btree_write(HFS_SB(inode->i_sb)-
>>>> cat_tree);
>>> 			return 0;
>>> 		default:
>>> 			BUG();
>>> 			return -EIO;
>>>
>>> I think we need to select something one here. :) I believe we need
>>> to remove
>>> BUG() and return -EIO, finally. What do you think? 

I think that removing this BUG() now is wrong.
Without my patch, the inode number of the record retrieved as a
result of hfs_cat_find_brec(HFS_ROOT_CNID) can be HFS_POR_CNID or
greater than HFS_FIRSTUSER_CNID, which I think is a logical error
in the filesystem image.

>>
>> I think that with validation of inodes in hfs_read_inode this code
>> path should
>> no longer be reachable by poking the kernel interface from userspace.
>> If it is
>> ever reached, it means kernel logic is broken, so it should be
>> treated as a bug.

Your patch is incomplete. Please also apply my patch.


