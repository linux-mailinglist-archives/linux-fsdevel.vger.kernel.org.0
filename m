Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A412F97B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 16:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgACPF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 10:05:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37745 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACPF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 10:05:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so30110526wru.4;
        Fri, 03 Jan 2020 07:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=X5+ayP/0hzBeWDiiokaoXUV3s80MSoMhBga4b9S7sks=;
        b=OphOn0vxqlZHvxhxkC7gFavcg8KUzD6thbTzOhjFjaBwVoRmNB8VfO1KaKsg0+uWh+
         eCTB8bn6Y+npzS6wYCGaH7avGMzRL6Z8oSNpa8+37wBkL1Ki8L6Vri+iwi2WOyo/akMv
         yoxr9xRKDbeTnRvAXnejWI8qMajzpZnBwCZqk2qdxB1uIBuBf446N7e3ndG0BiWbekMj
         GOp75VenYqte4WaHktOF38ySpwt8xWbaZ8butvV6BZisrj68WoDAzp1mwphj+rwUgwmi
         iwm1zXUKYlE6W9BLg4YYhHGRFbC7RBy6r91fLogs9yP7sPwUf6ll13c9R+G8KyDZwhbt
         2DpA==
X-Gm-Message-State: APjAAAUi358JJHZqDOJgLAkj6I8kY6Zn6/RWpVESWfpzWgI70nlVDxkn
        dWVyKre7jEh1W/kBJjBv5aM=
X-Google-Smtp-Source: APXvYqygr/6TniLTdugF+WqW3lwlKrSR9oQWEVDaSy91cNcI3WRlF+4XJBcs5clvoogcu5G/pibIzg==
X-Received: by 2002:adf:9144:: with SMTP id j62mr84290643wrj.168.1578063925002;
        Fri, 03 Jan 2020 07:05:25 -0800 (PST)
Received: from Johanness-MBP.fritz.box (ppp-46-244-218-95.dynamic.mnet-online.de. [46.244.218.95])
        by smtp.gmail.com with ESMTPSA id e8sm60583844wrt.7.2020.01.03.07.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 07:05:24 -0800 (PST)
Subject: Re: [PATCH v5 2/2] zonefs: Add documentation
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
References: <20200103023445.1352524-1-damien.lemoal@wdc.com>
 <20200103023445.1352524-3-damien.lemoal@wdc.com>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <e9df8ffe-96b2-f9c6-7f42-30f3b33097fb@kernel.org>
Date:   Fri, 3 Jan 2020 16:05:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200103023445.1352524-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Am 03.01.20 um 03:34 schrieb Damien Le Moal:
[...]
> +
> +Overview
> +========
> +
> +zonefs is a very simple file system exposing each zone of a zoned block device
> +as a file. Unlike a regular file system with zoned block device support (e.g.
> +f2fs), zonefs does not hide the sequential write constraint of zoned block
> +devices to the user. Files representing sequential write zones of the device
> +must be written sequentially starting from the end of the file (append only
> +writes).
> +
> +As such, zonefs is in essence closer to a raw block device access interface
> +than to a full featured POSIX file system. The goal of zonefs is to simplify
> +the implementation of zoned block device support in applications by replacing
> +raw block device file accesses with a richer file API, avoiding relying on
> +direct block device file ioctls which may be more obscure to developers. One
> +example of this approach is the implementation of LSM (log-structured merge)
> +tree structures (such as used in RocksDB and LevelDB) on zoned block devices
> +by allowing SSTables to be stored in a zone file similarly to a regular file
> +system rather than as a range of sectors of the entire disk. The introduction
> +of the higher level construct "one file is one zone" can help reducing the
> +amount of changes needed in the application as well as introducing support for
> +different application programming languages.

Maybe add a small subsection on what zoned block devices are? Given that
we had at least one person looking at this series while it was on the
list, who didn't really know what zoned block devices are and what the
constraints of them are.

[...]
> +Zone files
> +----------
> +
> +Zone files are named using the number of the zone they represent within the set
> +of zones of a particular type. That is, both the "cnv" and "seq" directories
> +contain files named "0", "1", "2", ... The file numbers also represent
> +increasing zone start sector on the device.
> +
> +All read and write operations to zone files are not allowed beyond the file
> +maximum size, that is, beyond the zone size. Any access exceeding the zone
> +size is failed with the -EFBIG error.
> +
> +Creating, deleting, renaming or modifying any attribute of files and
> +sub-directories is not allowed.

Nit: Above you explicitly say it's failed with -EFBIG, maybe document
the error here as well?

Other than that,
Reviewed-by: Johannes Thumshirn <jth@kernel.org>

