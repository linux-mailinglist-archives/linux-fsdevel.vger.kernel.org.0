Return-Path: <linux-fsdevel+bounces-49254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1224BAB9C6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF973BF65A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B0D23F42A;
	Fri, 16 May 2025 12:42:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82481D6DBB
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399330; cv=none; b=FoX73TsSBy1q4KBqyzs/Gzr7Lsk1Fzz8n1K2YwikRaniJNXNC3SLyIWRw3yUVp0YVI80MGgNbkS1kqFbMDSvyv4SKY9mGm6BY+1biODh+EJK0gojpDEEyE18/T9Pw7IU0shCbJ3rWbXlP09cHjg17Zdzpm1HgkfseLFXrfXn5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399330; c=relaxed/simple;
	bh=YSe6fcEN+uof2W9s91D94b/Q2FHo7/6bawqFJ//ZbTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcu3AaKvZ9S7QH0SL5x5Rhf80N9a0xaPJsXU6LN8wh5NfS+2QEeOqN8sZiGHrpVqxYsc4iJVBz2UkRfQjDbNO1wXRo2iUIujqJaeWlv8DrOkEIg/Ev/QNvftPkXvJjHsSSVMS3DUsWxId0BONBXZZlIgKDHW8ZY64+JPu1XvDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-151.bstnma.fios.verizon.net [173.48.112.151])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54GCfl0G015692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 08:41:48 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 54A972E00DE; Fri, 16 May 2025 08:41:47 -0400 (EDT)
Date: Fri, 16 May 2025 08:41:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Alejandro Colomar <alx@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: close(2) with EINTR has been changed by POSIX.1-2024
Message-ID: <20250516124147.GB7158@mit.edu>
References: <fskxqmcszalz6dmoak6de4c7bxt4juvc5zrpboae4dqw4y6aih@lskezjrbnsws>
 <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddqmhjc2rpzk2jjvunbt3l3eukcn4xzkocqzdg3j4msihdhzko@fizekvxndg2d>

On Fri, May 16, 2025 at 12:48:56PM +0200, Jan Kara wrote:
> > Now, POSIX.1-2024 says:
> > 
> > 	If close() is interrupted by a signal that is to be caught, then
> > 	it is unspecified whether it returns -1 with errno set to
> > 	[EINTR] and fildes remaining open, or returns -1 with errno set
> > 	to [EINPROGRESS] and fildes being closed, or returns 0 to
> > 	indicate successful completion; [...]
> > 
> > <https://pubs.opengroup.org/onlinepubs/9799919799/functions/close.html>
> > 
> > Which seems to bless HP-UX and screw all the others, requiring them to
> > report EINPROGRESS.
> > 
> > Was there any discussion about what to do in the Linux kernel?
> 
> I'm not aware of any discussions but indeed we are returning EINTR while
> closing the fd. Frankly, changing the error code we return in that case is
> really asking for userspace regressions so I'm of the opinion we just
> ignore the standard as in my opinion it goes against a long established
> reality.

Yeah, it appears that the Austin Group has lost all connection with
reality, and we should treat POSIX 2024 accordingly.  Not breaking
userspace applications is way more important that POSIX 2024
compliance.  Which is sad, because I used to really care about POSIX.1
standard as being very useful.  But that seems to be no longer the
case...

						- Ted

