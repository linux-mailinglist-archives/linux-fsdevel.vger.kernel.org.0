Return-Path: <linux-fsdevel+bounces-8779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E483AE5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF4AB2CC66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 16:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A97C7CF35;
	Wed, 24 Jan 2024 16:27:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [107.191.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBC7C0AE;
	Wed, 24 Jan 2024 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.191.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113658; cv=none; b=dcFlugMRhTeBW1MBC45ggdBRwP6KnvoTuE86aCDXVIc2gYE6sL8sDOXAl3RCLiWxV1p4mn2MzESm44TQLlT1IAF5UApj8SvOesRqSUpJuxHEphAZfG8vGmluKWT+nelZIj77dkgXlFLwFtrO9QlXjDxX/gtegHyg9GnxnWWje0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113658; c=relaxed/simple;
	bh=8IXyuu4tjLj5dpYsQhlmFqln1I9NrNe8kqylwjs7rtA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NTtU326ISKJJfiwvUOGF34ZnX5rQ4TnICWupvOFkHri5OVWcggO0HUtp0YVfyw1huC0fQV29q5gSHqX2FlKMp4s7kf6xzDEMwsxpTSHR8TTAShKj2NbYufmbdLiXdPTy7oqcbu868jaR9Gax5kSAvLlAiqedX6UeUvhXYGQjn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kevinlocke.name; spf=pass smtp.mailfrom=kevinlocke.name; arc=none smtp.client-ip=107.191.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kevinlocke.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevinlocke.name
Received: from kevinolos.kevinlocke.name (071-015-195-251.res.spectrum.com [71.15.195.251])
	(Authenticated sender: kevin@kevinlocke.name)
	by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 8873D41435DA;
	Wed, 24 Jan 2024 16:19:56 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
	id 1387213005B0; Wed, 24 Jan 2024 09:19:54 -0700 (MST)
Date: Wed, 24 Jan 2024 09:19:54 -0700
From: Kevin Locke <kevin@kevinlocke.name>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Kees Cook <keescook@chromium.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Message-ID: <ZbE4qn9_h14OqADK@kevinlocke.name>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Kees Cook <keescook@chromium.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linux developers,

Using AppArmor 3.0.12 and libvirt 10.0.0 (from Debian packages) with
Linux 6.8-rc1 (unpatched), I'm unable to start KVM domains due to
AppArmor errors. Everything works fine on Linux 6.7.  After attempting
to start a domain, syslog contains:

libvirtd[38705]: internal error: Child process (LIBVIRT_LOG_OUTPUTS=3:stderr /usr/lib/libvirt/virt-aa-helper -c -u libvirt-4fad83ef-4285-4cf5-953c-5c13d943c1fb) unexpected exit status 1: virt-aa-helper: error: apparmor_parser exited with error
libvirtd[38705]: internal error: cannot load AppArmor profile 'libvirt-4fad83ef-4285-4cf5-953c-5c13d943c1fb'

dmesg contains the additional message:

audit: type=1400 audit(1706112657.438:74): apparmor="DENIED" operation="open" class="file" profile="virt-aa-helper" name="/usr/sbin/apparmor_parser" pid=6333 comm="virt-aa-helper" requested_mask="r" denied_mask="r" fsuid=0 ouid=0

The libvirt-$GUID file is not created in /etc/apparmor.d/libvirt and
apparmor_parser is not executed as far as I can tell.

I've bisected the regression to 978ffcbf00d82b03b79e64b5c8249589b50e7463.
Perhaps the change in this commit causes AppArmor to deny opening
/usr/sbin/apparmor_parser in preparation for exec?  For reference, 
/etc/apparmor.d/usr.lib.libvirt.virt-aa-helper contains:

  /{usr/,}sbin/apparmor_parser Ux,

I'd appreciate any help debugging the issue further.  Let me know if I
should take it up with the AppArmor or libvirt developers to better
understand the issue.

Thanks,
Kevin

