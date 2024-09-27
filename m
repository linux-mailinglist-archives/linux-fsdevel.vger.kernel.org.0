Return-Path: <linux-fsdevel+bounces-30270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB80988B26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB171F22F5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6121C2DCD;
	Fri, 27 Sep 2024 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OXw4eh88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E5B16A949;
	Fri, 27 Sep 2024 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727468129; cv=none; b=qWCUzP3tkwDVHo1uqGS0lrRs4Igw4RoVQ+Xq+P6I4HdwgO3hvVdrw7mx5wI6SWNetzk7kbYIrIRl5hYoVzLjcBCeJ5kaoVPcS7qd2HMrWt2yV8BT0v58uQH9lZb3aKpvC49F8iro8tOtnnxsEM6zwfColg4JI/tigj39Uv2RR3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727468129; c=relaxed/simple;
	bh=sUcXjqJXesE5GUuxXbEF77J3wkvDa6pF3vtCYKKPeM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqB19OJzikWX+9LgsnZZCL2OXa2VxPT7KijNj9QVPQsphcz7oefR6Dv0myHapMnXB8/I1FVp6G3bLeqmKZBEyPaQMXShM5KSmDBpA+PJUj+LO1jpr3gxnyNKiL8BpLlspd/qH4LgD+wda7JPPIomDHRrLUEHAcxqI+gp4zFXCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OXw4eh88; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sUcXjqJXesE5GUuxXbEF77J3wkvDa6pF3vtCYKKPeM0=; b=OXw4eh88Ab9lDK7EfV20df3MVK
	dDMqG0syFywlMqObd7HH3Eviv/iYr/vOPzZ4PiCFf+xWmA+f+VE9emHmiph1E8bAabjK82tGPc4of
	ZdfJlo0XMQYEZSpFFKozOM4xxzc0N6YwYgds4H8KqGdZtr9+h2wnZQCic85dsZt4zkLKGrHBxMTx6
	DcVJqE3shOIGZy2XVODKztg1/DFese7cqUIb5MYQ/tZc8zZgFqTPIjEP4RXTCoyGE6oHFqiZxVN6X
	V6sgMAffTsd992/R8fEDnAxSBG2E5YBURURxc0FnOscpmtMh1I4ezSTJDrKwL8YGA9rJ5R1m6AulG
	oqG1W7rA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1suHN4-0000000G3i8-0fwy;
	Fri, 27 Sep 2024 20:15:22 +0000
Date: Fri, 27 Sep 2024 21:15:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Leo Stone <leocstone@gmail.com>,
	syzbot+d9efec94dcbfa0de1c07@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
	skhan@linuxfoundation.org, anupnewsmail@gmail.com,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_llseek
Message-ID: <20240927201522.GW3550746@ZenIV>
References: <k53rd76iiguxb6prfmkqfnlfmkjjdzjvzc6uo7eppjc2t4ssdf@2q7pmj7sstml>
 <CAOQ4uxhXbTZS3wmLibit-vP_3yQSC=p+qmBLxKkBHL1OgO5NBQ@mail.gmail.com>
 <CAOQ4uxiTOJNk-Sy6RFezv=_kpsM9AqMSej=9DxfKtO53-vqXqA@mail.gmail.com>
 <CAHk-=wikugk2soi_2OFz1k27qjjYMQ140ZXWeOh8_9iSxpr=PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wikugk2soi_2OFz1k27qjjYMQ140ZXWeOh8_9iSxpr=PQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 27, 2024 at 12:47:16PM -0700, Linus Torvalds wrote:

> But I still strongly suspect that to make it more likely that I don't
> miss anything, you make the subject line some big clue-bat to my head
> like having "[PATCH-for-linus]" header.

BTW, what do you prefer for "please run this script with this explanation
just before -rc1" kind of stuff?

Example: https://lore.kernel.org/all/20240927015611.GT3550746@ZenIV/

I've used "[tree-wide]" as a prefix, but I've no idea what your preferences
would be in that respect...

