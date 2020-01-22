Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B40145938
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 17:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgAVQCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 11:02:35 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:38230 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAVQCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:02:34 -0500
Received: by mail-il1-f174.google.com with SMTP id f5so5527703ilq.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 08:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkkBulRfFcaILGpsEq52tmNefXtFSwFkknnr5JWDFPo=;
        b=q16enS5dgT0AvlX+rQCwZhh8Gtmspa8pwOj753CKESy0YsFgSmgqSmeY6Fjzc7aecX
         xsaaljwlVl9jDD/4mplItQUKz8YwB2xesB9gb5puI9AqCHKV3AMHotoVI3V85Tj9IXzc
         asIql5R/HvWLkZVc1kEm8cuqToGvLgqGJCpGOIExcIsajIwaeBHTyb7Rdudi9RseMjd9
         bodFaZww9PBm3LluhVHUauHcdWc2UGeo8zrGlccALzDlYaI7JJe0ykX9fTuEShreuFT+
         8vGcy5+OR8F/TKG7IjccVOM3pT8DFMTOe9teqaQDr3oAi260Vb/Z0aayVhiPMwikzCLS
         aCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkkBulRfFcaILGpsEq52tmNefXtFSwFkknnr5JWDFPo=;
        b=TtqNOY1Yha60sjKHr6S0x6ABEG+fpw50VsKVNUPNJgAk+JL6CqurqwHVFV8fF+pSEk
         OTnBU7OmIYQgkMVdF7pj54nv9h1ynSjdsKLY5S0+iP4VWHvaWYUU8CxD0EDPtF5//xFL
         9AIn4mCHerQDVBXwGlJkH3ApR1pRnBfFoUwwpNscEv/N2xKA+sabZvxdzTDSTf5Pimlh
         CG16Hy8CItdMqulMx+03huv+EHG7vwCt9ubWO1T8kC9wNLXuI5sGfQ90g7XTOeSQoDyG
         vm5e6hdN7TYZosqgYOtyFF7/op07u26hvXvfphGbaswqXiozKnxp+z4Fqqw6AhG+6sdp
         4s9w==
X-Gm-Message-State: APjAAAUAjiIT0UBAYA1BjKZW6tigcNE3vxkgl+mu4fiZ1A5wA8ppNwJr
        0/JxShqxOs9s19nki3pJZQNMrw==
X-Google-Smtp-Source: APXvYqyK3mVXqUdP8atBQpf4r3XNJ+ieg2SfmpxvukRECA00+9rPqTteGj8oFdr2fyB761FbbT95tQ==
X-Received: by 2002:a92:b06:: with SMTP id b6mr8253760ilf.127.1579708954006;
        Wed, 22 Jan 2020 08:02:34 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v206sm796924iod.41.2020.01.22.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:02:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCHSET 0/3] Add io_uring support for epoll_ctl
Date:   Wed, 22 Jan 2020 09:02:28 -0700
Message-Id: <20200122160231.11876-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds support for epoll manipulation through io_uring, in particular
epoll_ctl(2). Patch 1 is just a prep patch, patch 2 adds non-block
support for epoll, and patch 3 wires it up for io_uring.

Patch 2 isn't the prettiest thing in the world, but we need to do
nonblock grabbing of the mutexes and be able to back out safely.

Please review, thanks.

-- 
Jens Axboe


