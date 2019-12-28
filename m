Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09E212BDF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2019 16:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfL1P4H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Dec 2019 10:56:07 -0500
Received: from mail-yw1-f54.google.com ([209.85.161.54]:43575 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfL1P4H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Dec 2019 10:56:07 -0500
Received: by mail-yw1-f54.google.com with SMTP id v126so12409378ywc.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2019 07:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zBKriwPr9SjhrT1rbedlNBs+ksD2sfIqjCoI891MWPs=;
        b=l1eZV8JX2jAkH0UM26O8m3K8dBUegCacg5w3gNaT29pmc3+BdyJa7pxFCSWsKgCovT
         vP4KgN7D7oeb6Scpp9bgcxorOLmMk2UKogyYPK57z6YLPyF95NDiAn0DMdzxhO3vs/4U
         PjryuSO4H4uCqOnt5wAS2uV7mIJGQk8/+bOfMy/K2vhuOeWvjOgaclUGhrgahnqW02sY
         kHg0QrUeRENcCRUYLh4E9FFsrdBnvhjk7uPgtIo71eDcRSBO127PCWeXXWyJz5WEuz4B
         gAu82relgSiJTzIDm5jjPiZT0x0J5Xb79CRMYwlOdpcov4PS029jE7mw9rsoj+0n6FXW
         T4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zBKriwPr9SjhrT1rbedlNBs+ksD2sfIqjCoI891MWPs=;
        b=re5vWmQIxAlfLI95x0jv9wcGWG4qZAS4Fb8e7XxOfePcTVwnwXeLKBnNUhcGrYxmKO
         N1n9qJ5Fx7B9KQlSY+zag2st+k5FANzQ2MqoXWuSdRA4CAIi+n4JGlwA0CIGTbgpaqoF
         OAwjYaRVtIKXS0pdFstN2yJ9Ka4HztIbC7X7igXa+4js0uGhZ+yt5xZzXtggtYm3git5
         HsBbqYvgyElmq41ZzO/eO1DF8Tv23AeqDT43agk3dOTJ3TV6y9S9qXDcudymFdKotUYU
         h0r/X9lJluFSQva2D4Y2KLECqbZOog2W7KAz5LYiAUb+D/JBVPLdIJ8BF6ZlK39CgJFV
         awGg==
X-Gm-Message-State: APjAAAWmW8RQstZC8/wVl1/jNqzMvmX/GiPAuFYXGpB705kMltqNWJUr
        58QwnguwB9VvClzT6ad8bwmag43PB6E=
X-Google-Smtp-Source: APXvYqzZfcbEYlUedemsz8I1B0nkfg7XCAUIJd7Fup3FEzaCaHwqQ6ZU3g2bYNO9yE05NdD+l8mU3w==
X-Received: by 2002:a81:a1c4:: with SMTP id y187mr40489367ywg.189.1577548566104;
        Sat, 28 Dec 2019 07:56:06 -0800 (PST)
Received: from user-ThinkPad-X230 ([2601:cd:4005:d680:3149:3009:57c4:ce8])
        by smtp.gmail.com with ESMTPSA id w128sm14576601ywf.72.2019.12.28.07.56.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 07:56:05 -0800 (PST)
Date:   Sat, 28 Dec 2019 10:55:59 -0500
From:   Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Subject: flag specifications for structs
Message-ID: <20191228155559.GA2115@user-ThinkPad-X230>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello fellow kernel hackers,

I am currently considering tackling the following item
from the TODO list in the drivers/staging/exfat directory:

	Fix (thing)->flags to not use magic numbers - multiple
	offenders

I am having some difficulty figuring out what the flag bits
of the following two structs, defined in exfat.h, mean:
	
	/* directory structure */
	struct chain_t {
		u32      dir;
		s32       size;
		u8       flags;
	};

	struct file_id_t {
		struct chain_t     dir;
		s32       entry;
		u32      type;
		u32      attr;
		u32      start_clu;
		u64      size;
		u8       flags;
		s64       rwoffset;
		s32       hint_last_off;
		u32      hint_last_clu;
	};

Are the bit specifications defined somewhere in the
linux kernel or online? Any guidance on how to go about figuring 
them out would be much appreciated.  
