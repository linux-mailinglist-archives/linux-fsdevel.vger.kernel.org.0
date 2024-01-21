Return-Path: <linux-fsdevel+bounces-8374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8BE8357FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 22:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FAA1F219E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 21:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EE738DE9;
	Sun, 21 Jan 2024 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XNuJOwDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164CF36B04
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 21:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705873866; cv=none; b=sI1wisuiRVx9HFWn7jqN0xg8Muh2OXFUuudskBJS4y0KBFNEWFZtUtzFZPrnG887T5ndua3YzkowVuWvzPJxcKvRSHIHLPVf1SWSQnxuhFTp5D05Wmg0k9+wMpCe0KAUJWPjoPPJPmY+qptpFKomKDOIOjFc3yNCaizanGiOQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705873866; c=relaxed/simple;
	bh=e8/eHH/8Os+EruXNQHe/MytsP1WSv6RIhsXffvwgFmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZqqoxi+D70YonOiXI4vGpRlS+bg+FM4BRH0JVKt5GGhd99ncgHYSLVc+kD8YzDxE6NkldJv5ylnbOon46+tdy3iCY4CweiguJ3qQ1AN8dLc9aYTWWTM+20BJBNLhsckIc6qC3UiAhQGKKBvKJ+/4xX15+0/IjO7JzwwhcR4JFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XNuJOwDc; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bedd61c587so79034839f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 13:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705873863; x=1706478663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIAOAmfmOn6HuODB3CsU29FgEopZmi1NGSSNaqzbpY0=;
        b=XNuJOwDczQ+00LEoGo1VOwPkujnMOyy8J+aBrw4CLWRc5BscwtgrclzGIBVJy3RyBZ
         6pquohWu7HYrdtmVCbOeDKYo0oIyICHm8OQtX+uVvcNQcZdqR7KP3Dcf7xJkBTFbD4TP
         Nobr4od1FUfKNQDPqP0KN7WW6mnsQcz9xUGe7vSkZxBMOVLZ/Ly8QWQq+5DrbvC2Qa2x
         i9utPHjPCpJrT2hD5gdMI1LhJyIL4/mo2v3UIf4aYFRhC+MqRj1BrnZFgBSd84H9O/kg
         acgUOVJOtd4FoVS0qVmMSqoReuiSCvWgunztkCF561xLYi5cHVF41H5O+ZA2Kt/vfO8V
         DP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705873863; x=1706478663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIAOAmfmOn6HuODB3CsU29FgEopZmi1NGSSNaqzbpY0=;
        b=DiV9IWJOBOdu/A+aVP3c+XuQLteXk5KhEPVHmlghBmOtZAqQc7Dh2CgUfu89pIs/Gr
         z6m89T8Mk/kvGrXmowwh668fMHQOtJJqvtVpy/sz9Bs7JQCaBbQk5ZixizjxQl/0IN56
         AEu0A398augvLZuQQvWO2bcc3dqYrHBBEqFZ+MV1SDGCxzSOUXSw3F3sfsHO3CWdy6fm
         VbAWrUL+ZT0eW+CEEXnnUSmeTTYK66MqgA3XBUMo4Mp0cQsfYDaWjI9y/Wi+imx9jk4a
         gYP3hCmtZX5HExhLT6XhCVdQNk/Z/gv0g+osWDfWu65qosAVa5F68s6cqDjkLxMR3j3Y
         OF2A==
X-Gm-Message-State: AOJu0Yy97498WZIq2uJpzjFuX8ZGsTbfDW2ftzmYAKVycDAsVTEM+Lcj
	MhVhDbZ2pkWqHDRT1EUgxOiM9/hVY8Njz/0iqFI3zufu0gTTXCRvfR7CM3i0DJE=
X-Google-Smtp-Source: AGHT+IHQ6ry5vTW5x85A9d0dL7gYg/4lpV5q3/dH1PwN74lOagyItZ0zxUAVZk4ytaOcxGHrMcmOcQ==
X-Received: by 2002:a5d:9b15:0:b0:7be:e36f:c84c with SMTP id y21-20020a5d9b15000000b007bee36fc84cmr3172078ion.6.1705873863167;
        Sun, 21 Jan 2024 13:51:03 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id u8-20020a170903124800b001d60a70809bsm6144359plh.168.2024.01.21.13.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 13:51:02 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rRfiW-00DV9k-0I;
	Mon, 22 Jan 2024 08:51:00 +1100
Date: Mon, 22 Jan 2024 08:51:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: wedsonaf@gmail.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	kent.overstreet@gmail.com, linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, viro@zeniv.linux.org.uk,
	walmeida@microsoft.com, willy@infradead.org
Subject: Re: [RFC PATCH 07/19] rust: fs: introduce `FileSystem::read_dir`
Message-ID: <Za2RxF7iGOkI4A0e@dread.disaster.area>
References: <20231018122518.128049-8-wedsonaf@gmail.com>
 <20240121210049.3747-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121210049.3747-1-safinaskar@zohomail.com>

On Mon, Jan 22, 2024 at 12:00:49AM +0300, Askar Safin wrote:
> Wedson Almeida Filho:
> > +    /// White-out type.
> > +    Wht = bindings::DT_WHT,
> 
> As well as I understand, filesystems supposed not to return
> DT_WHT from readdir to user space. But I'm not sure. Please,
> do expirement! Create whiteout on ext4 and see what readdir
> will return. As well as I understand, it will return DT_CHR.

DT_WHT is defined in /usr/include/dirent.h, so it is actually
present in the userspace support for readdir. If the kernel returns
DT_WHT to userspace, applications should know what it is.

However, filesystems like ext4 and btrfs don't have DT_WHT on disk
and few userspace applications support it. Way back when overlay
required whiteout support to be added, the magical char device
representation was invented for filesystems without DT_WHT and that
was exposed to userspace.

We're kind of stuck with it now, though there is nothign stopping
filesysetms from returning DT_WHT to userspace instead of DT_CHR and
requiring userspace to stat the inode to look at the major/minor
numbers to determine if the dirent is a whiteout or not.  Indeed, it
would be more optimal for overlay if filesystems returned DT_WHT
instead of DT_CHR for whiteouts.

Put simply: DT_WHT is part of the readdir kernel and userspace API
and therefore should be present in the Rust interfaces.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

