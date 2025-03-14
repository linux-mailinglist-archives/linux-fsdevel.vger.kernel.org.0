Return-Path: <linux-fsdevel+bounces-44024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36304A6111D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 13:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F9E1899E5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 12:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B891FECD3;
	Fri, 14 Mar 2025 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NivtYPNM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C151FE463;
	Fri, 14 Mar 2025 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955300; cv=none; b=Yqn1KCP5e1dgqMrh2z91yflCGeNHs9JkdhOTCn1Yd0NGcK372Gk69qoE5ooY+kOWhyHM40G82z068ZxpDmkChrP6Yi74H6ce2jqeEqMCA0uSUskdltq8oQuh+h37plEX6rKTazfm/PP/sFntRoo8cz41d01aYGSf31gjctmVEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955300; c=relaxed/simple;
	bh=IXSKdqLnjW67NRFC9bjAgmICki6llRJloDGpUGAx5iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=aYXEfMk8nIqqVsgVHBjL9IK2VhWH7pvrt7Bh4gT/QPsorWrxblnH+uN0tO5BbOICQ/zgZs7u+/HBypZr9x0hj55NS0F5hWapj8DSS5K0TGOciLwCX7tjBFINX2mEkw/kKNp2ShfDR2nPCzQDWXpP8g2zpm0EE1sfWT3/TMexcJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NivtYPNM; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2240b4de12bso54368515ad.2;
        Fri, 14 Mar 2025 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741955298; x=1742560098; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ynBbWUcVnkRYMM7LmAvidRvA8Mc8m9I5HXU+6p6f3ek=;
        b=NivtYPNMPLQDOI7rJuq4vqVoPfzYAu5nFB+KzI3yK/yXsdBbLKWGUtXH19XSVhXxB2
         aGwwwhCBm2GFbPDZZxdSqSf9Tt6pKc6PbJSSM9w1A5OY1EPk6TzVkZ4oantaCZTKvNE+
         xtMUAPsq8zc5gzpaJMKWmvtxLInBc/VeNkwtIEZOWdar6U3IKPrHDokn14RAcMBWkgEz
         25/0OsPCLA2EL3rdV1AYsmTSMhpDm/RpjRkPnvo9IIKMI5Ec8NsaAuZiAc+wDy6n6cAB
         vCy1I8Y5LN/uESMoPPllP37hteQXF/unedF1pzmgIhgd+qisz1wusRCGHDkcQa706LZl
         f7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955298; x=1742560098;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynBbWUcVnkRYMM7LmAvidRvA8Mc8m9I5HXU+6p6f3ek=;
        b=SFxUEncu2zvGgjriPEVEEhNUQfXmoDdN4y3m6ECkEQMNe/Q6pDPJY0AmS2hFQjX9KI
         VNWGEN3UCYrv+h8PSBaCtEezohNbloEMoHcdzNXnvhY/7CsoRXvwQ1drpd3BWXPdfD96
         wfy9QDRTKw4cl719PW7euAXVCKl+Fzzt3WjlNPm4B+u1pfkzA/YVZKVI5OWCUPcPhwCB
         5ESfyLNc3hp3SVvgTeJi4uuAuy4BYIMcD1IvIlo9YHX+AkKIZ9ZUhoQ2uT0lDSRpKxjP
         25/EEeZuq73GlLBuFHNR2tHP1ytGvAE9yrZlB9fEw4T3Ky1EmkTfUvsUZ+n5SCxjH2DO
         wJmA==
X-Forwarded-Encrypted: i=1; AJvYcCU5US9sJBmRy66WkbGuYSiaxBM7c10m3Z0KoysTRKPOw5iR4b+pjPMd6mnuN6xJrB8+e73WP0gmEjH/esGb@vger.kernel.org, AJvYcCU6owcBPIYwUWVGzz+37tRP5bwo5AOg0r4k25n+53cXiull8dzU/SuI9ih07fWETvw18nWMJtasWF4=@vger.kernel.org, AJvYcCXo/zj4WRHQc40p8aTVHtNKfpf8a6eZVtxN8QMaAQ4fxErvyyhYXBymK68V44idV39jwe9pkzhNQWL0pASTkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKHM1sTHySup+WpZnr2JFryQzWKudHsniW/zRnCHmFBtitKeFI
	HgpECdDf7KxAu8oU/uSgAp93A33qtLInBJXZOZxEnvAwFWfuff9E
X-Gm-Gg: ASbGncsbyTd7tY0H7NtjhmIBnrLlHmD/fwHfUjecBrqwZhyeqaqBt1z1ayzyqvQ0unv
	MakfgzZpA6OujJ56Uz9CAZh/Om7DfjWpLLRpvOnfRVi0btfatZGqgXNAUVo7NTSuhCbbizzPnuw
	S3MyXfM4h23psStDRqfxzzxmlPL7+Hx33jLatCZFJRo/WIHWFjbX1lMDBFsh9ExV/qrVn7KGGp5
	rUqL3A86TmuBJLf8POsAMHLfG5/NUWMPOAFe4KVsMmiKdFa5HG01aRwGO5L7zsPNpgjllBlucwc
	8OASWacCHlXwR+6UZ3yizW9jErB9BrRIGyzrZ529WqGF77OnmJdhuYdcVrw8IkE1b+OMzF3vkZu
	I+fY=
X-Google-Smtp-Source: AGHT+IEZAZwWnGP7LiFOlIUFfP0BfOnOzMXFuLtArMgmoKSSNawUW2X5dkuB6d1nbDL7ycOwbkZ2Fg==
X-Received: by 2002:a17:90b:524d:b0:2ff:5ed8:83d1 with SMTP id 98e67ed59e1d1-30151cab34fmr2864229a91.19.1741955297702;
        Fri, 14 Mar 2025 05:28:17 -0700 (PDT)
Received: from localhost.localdomain ([103.49.135.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301539d40d7sm876101a91.9.2025.03.14.05.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Mar 2025 05:28:17 -0700 (PDT)
From: Ruiwu Chen <rwchen404@gmail.com>
To: joel.granados@kernel.org,
	mcgrof@kernel.org
Cc: corbet@lwn.net,
	keescook@chromium.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rwchen404@gmail.com,
	viro@zeniv.linux.org.uk,
	zachwade.k@gmail.com
Subject: Re: [PATCH v2] drop_caches: re-enable message after disabling
Date: Fri, 14 Mar 2025 20:28:03 +0800
Message-Id: <20250314122803.14568-1-rwchen404@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <db2zm4c5p5octh6garrnvlg3qzhvaqxtoz33f5ksegwupcbegk@jidbmdepvn57>
References: <db2zm4c5p5octh6garrnvlg3qzhvaqxtoz33f5ksegwupcbegk@jidbmdepvn57>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> On Wed, Mar 12, 2025 at 03:55:22PM -0700, Luis Chamberlain wrote:
> > On Mon, Mar 10, 2025 at 02:51:11PM +0100, Joel Granados wrote:
> > > On Sat, Mar 08, 2025 at 04:05:49PM +0800, Ruiwu Chen wrote:
> > > > >> When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
> > > > >> but there is no interface to enable the message, only by restarting
> > > > >> the way, so add the 'echo 0 > /proc/sys/vm/drop_caches' way to
> > > > >> enabled the message again.
> > > > >> 
> > > > >> Signed-off-by: Ruiwu Chen <rwchen404@gmail.com>
> > > > >
> > > > > You are overcomplicating things, if you just want to re-enable messages
> > > > > you can just use:
> > > > >
> > > > > -		stfu |= sysctl_drop_caches & 4;
> > > > > +		stfu = sysctl_drop_caches & 4;
> > > > >
> > > > > The bool is there as 4 is intended as a bit flag, you can can figure
> > > > > out what values you want and just append 4 to it to get the expected
> > > > > result.
> > > > >
> > > > >  Luis
> > > >
> > > > Is that what you mean ?
> > > >
> > > > -               stfu |= sysctl_drop_caches & 4;
> > > > +               stfu ^= sysctl_drop_caches & 4;
> > > >
> > > > 'echo 4 > /sys/kernel/vm/drop_caches' can disable or open messages,
> > > > This is what I originally thought, but there is uncertainty that when different operators execute the command,
> > > > It is not possible to determine whether this time is enabled or turned on unless you operate it twice.
> > >
> > > So can you use ^= or not?
> > 
> > No,  ^= does not work, see a boolean truth table.

I don't quite agree with you, you change this, 
echo {1,2,3} will have the meaning of enable message

The initial logic:
echo 1: free pagecache
echo 2: free slab
echo 3: free pagecache and slab
echo 4: disable message

If you change it to something like this:
stfu = sysctl_drop_caches & 4;
echo 1: free pagecache  and enable message
echo 2: free slab       and enable message
echo 3: free pagecache  and enable message
echo 4: disable message

echo 4 becomes meaningless, when echo 4 only the next message can be disabled
Unable to continuously disable echo{1,2,3}

echo {1,2,3} always enabled the message
echo {1,2,3} should not have the meaning of enabling messages

My thoughts:
stfu ^= !!(sysctl_drop_caches & 4);
echo 1: free pagecache
echo 2: free slab
echo 3: free pagecache
echo 4: disable message(odd-numbered operation), enable message(even-numbered operation)

{1, 2, 3} & 4 = 0
stfu ^ 0 = stfu
when echo{1, 2, 3} the stfu is not affected

0 ^ 1 = 1 echo 4: disable message(odd-numbered operation)
1 ^ 1 = 0 echo 4: enable message(even-numbered operation)
stfu ^ 1 = !stfu

when echo 4
stfu(0) -> stfu(1) -> stfu(0) -> stfu(1) -> stfu(0) -> ...
 
> >
> > > And what does operate it twice mean?

echo 4 can:
stfu = 1 # turn off
stfu = 0 # turn on
stfu = 1 # turn off
stfu = 0 # turn on
...

> >
> > I think the reporter meant an "sysadmin", say two folks admining a system.
> > Since we this as a flag to enable disabling it easily we can just
> > always check for the flag as I suggested:
> >
> > stfu = sysctl_drop_caches & 4
> I sent out a new version of this patch. Its a bit late to push it though
> the next merge window, so it is in sysctl-testing until the next cycle
> 
> Thx again
> 
> Best
> 
> -- 
> 
> Joel Granados

Ruiwu

