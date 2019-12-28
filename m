Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BECD12BE12
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2019 17:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfL1QpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Dec 2019 11:45:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38436 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfL1QpR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Dec 2019 11:45:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so15959770pgm.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2019 08:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AYkts1eovGjgbdZ7k/AakR4b5OhMGezW+YjD4KO7Bnk=;
        b=xp8alS7sVd4XB0SSnwaU47yoTSoXzEbl8jF5H8Zh/BDNKYGbmw+jMfWLSQsSW/2PYI
         7Xuzxg1BkMVoTx29ZIsXwLrjs3msBwiHmW6IbVojpD4cwfEkmeUfgLbkPoMPMfKHS2TX
         BNUuaYvV3vzpCoAPNn4K70qdc7zBDhOfZrvu8IFeeHUyr+Ei2DA++E7ORWTxKefOtKlU
         9083fOwT2WIep+7wg7N3s4dNUCY4spfvGWapqVd4nEo3FxQqiB0a9Wn9/F74GMBmQ3zk
         D7HaG65r/fHTyooPjzsc4rjhm95NZ+0mFNrnBasaEx9n3Fj2ZLoKZe0A5vLco+bamAgG
         Le0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AYkts1eovGjgbdZ7k/AakR4b5OhMGezW+YjD4KO7Bnk=;
        b=s4N4Z5wtN0lEnI/sq/xVIUj+jJ+qFEzDTx8S6RmtL6PsSdoeV4qCWrlk8knH0GwVVD
         pMs4A0qWYK8UAbyG5LrbzIrJTBJ22cQaaP0fjf/eJYFoit3Z8lazT2uDXikYN/TPo985
         Xg7rhCs/XCqts9yvMlX2ygimSL31OxmEQpqP0CbyQMkOp4ha0p5lFhN37VURioBOiy7j
         +PZOsUMrpKeKHirSGYxhoyrrKVGHHgjC5ZaKH7pI75ca2tUBL8ZZUDlzgzQySLyO+waz
         YRZS7LvnD5NxkyuZ3xQkRUXVmcXeeC0oXdzTjiUo5ezeulcF1OnHWqoGash+VsSmyC+I
         3i5Q==
X-Gm-Message-State: APjAAAX8x8g28uMuqJTf9KeoIJ0FuvFAovqER17gBZm/Wcl8xbCSLO2h
        wpk/6o4QJkthB7uT5wQeETU7NQ==
X-Google-Smtp-Source: APXvYqzCmHQ0esSglX0MBu3j8n5QaAb0piDBm6xN4VpdAQRSyYsh9CXNkdTCak5hADDckLDTbQMIMQ==
X-Received: by 2002:a62:1a16:: with SMTP id a22mr61134705pfa.34.1577551516975;
        Sat, 28 Dec 2019 08:45:16 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id n1sm44860826pfd.47.2019.12.28.08.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Dec 2019 08:45:16 -0800 (PST)
Subject: Re: [PATCH V2] block: add bio_truncate to fix guard_bio_eod
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        syzbot+2b9e54155c8c25d8d165@syzkaller.appspotmail.com
References: <20191227230548.20079-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bcc25948-7250-7c82-a764-91ce4c938185@kernel.dk>
Date:   Sat, 28 Dec 2019 09:45:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227230548.20079-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/27/19 4:05 PM, Ming Lei wrote:
> Some filesystem, such as vfat, may send bio which crosses device boundary,
> and the worse thing is that the IO request starting within device boundaries
> can contain more than one segment past EOD.
> 
> Commit dce30ca9e3b6 ("fs: fix guard_bio_eod to check for real EOD errors")
> tries to fix this issue by returning -EIO for this situation. However,
> this way lets fs user code lose chance to handle -EIO, then sync_inodes_sb()
> may hang for ever.
> 
> Also the current truncating on last segment is dangerous by updating the
> last bvec, given bvec table becomes not immutable any more, and fs bio
> users may not retrieve the truncated pages via bio_for_each_segment_all() in
> its .end_io callback.
> 
> Fixes this issue by supporting multi-segment truncating. And the
> approach is simpler:
> 
> - just update bio size since block layer can make correct bvec with
> the updated bio size. Then bvec table becomes really immutable.
> 
> - zero all truncated segments for read bio

Applied, thanks.

-- 
Jens Axboe

