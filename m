Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEAB6B8BAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2019 09:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437555AbfITHjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 03:39:39 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:43180 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437540AbfITHjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:39:39 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 5E4D72E0C5F;
        Fri, 20 Sep 2019 10:39:35 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id h73mwB2F3n-dYf4bWMG;
        Fri, 20 Sep 2019 10:39:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1568965175; bh=ubtOdnbrGx18MOb4pKYMBiS7kvubYXq84YTGomjN01I=;
        h=In-Reply-To:Message-ID:Date:References:To:From:Subject:Cc;
        b=HA3liC6rKCR6XkN3Srs476pSOA2c50zD4eFE85eoxofTrsnJ6rYtKVCV/716lD38x
         AKH5vYTvFiM5fm0gBQfu2/MdvhJdClMuU+F/Wwh2IdTpsbjZB8vu9vSkUkz/5YkgG3
         JAAhxDDddFeknoqTnDNnvFBc+7oU9+nQk138UtRM=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:344a:8fe6:6594:f7b2])
        by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id wRyjSS3iHL-dYHGZC5S;
        Fri, 20 Sep 2019 10:39:34 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
Message-ID: <875f3b55-4fe1-e2c3-5bee-ca79e4668e72@yandex-team.ru>
Date:   Fri, 20 Sep 2019 10:39:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156896493723.4334.13340481207144634918.stgit@buzz>
Content-Type: multipart/mixed;
 boundary="------------2968E12483D6FA93813D5D46"
Content-Language: en-CA
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2968E12483D6FA93813D5D46
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Script for trivial demo in attachment

$ bash test_writebehind.sh
SIZE
3,2G	dummy
vm.dirty_write_behind = 0
COPY

real	0m3.629s
user	0m0.016s
sys	0m3.613s
Dirty:           3254552 kB
SYNC

real	0m31.953s
user	0m0.002s
sys	0m0.000s
vm.dirty_write_behind = 1
COPY

real	0m32.738s
user	0m0.008s
sys	0m4.047s
Dirty:              2900 kB
SYNC

real	0m0.427s
user	0m0.000s
sys	0m0.004s
vm.dirty_write_behind = 2
COPY

real	0m32.168s
user	0m0.000s
sys	0m4.066s
Dirty:              3088 kB
SYNC

real	0m0.421s
user	0m0.004s
sys	0m0.001s


With vm.dirty_write_behind 1 or 2 files are written even faster and
during copying amount of dirty memory always stays around at 16MiB.


On 20/09/2019 10.35, Konstantin Khlebnikov wrote:
> Traditional writeback tries to accumulate as much dirty data as possible.
> This is worth strategy for extremely short-living files and for batching
> writes for saving battery power. But for workloads where disk latency is
> important this policy generates periodic disk load spikes which increases
> latency for concurrent operations.
> 
> Also dirty pages in file cache cannot be reclaimed and reused immediately.
> This way massive I/O like file copying affects memory allocation latency.
> 
> Present writeback engine allows to tune only dirty data size or expiration
> time. Such tuning cannot eliminate spikes - this just lowers and multiplies
> them. Other option is switching into sync mode which flushes written data
> right after each write, obviously this have significant performance impact.
> Such tuning is system-wide and affects memory-mapped and randomly written
> files, flusher threads handle them much better.
> 
> This patch implements write-behind policy which tracks sequential writes
> and starts background writeback when file have enough dirty pages.
> 
> Global switch in sysctl vm.dirty_write_behind:
> =0: disabled, default
> =1: enabled for strictly sequential writes (append, copying)
> =2: enabled for all sequential writes
> 
> The only parameter is window size: maximum amount of dirty pages behind
> current position and maximum amount of pages in background writeback.
> 
> Setup is per-disk in sysfs in file /sys/block/$DISK/bdi/write_behind_kb.
> Default: 16MiB, '0' disables write-behind for this disk.
> 
> When amount of unwritten pages exceeds window size write-behind starts
> background writeback for max(excess, max_sectors_kb) and then waits for
> the same amount of background writeback initiated at previously.
> 
>   |<-wait-this->|           |<-send-this->|<---pending-write-behind--->|
>   |<--async-write-behind--->|<--------previous-data------>|<-new-data->|
>                current head-^    new head-^              file position-^
> 
> Remaining tail pages are flushed at closing file if async write-behind was
> started or this is new file and it is at least max_sectors_kb long.
> 
> Overall behavior depending on total data size:
> < max_sectors_kb - no writes
>> max_sectors_kb - write new files in background after close
>> write_behind_kb - streaming write, write tail at close
> 
> Special cases:
> 
> * files with POSIX_FADV_RANDOM, O_DIRECT, O_[D]SYNC are ignored
> 
> * writing cursor for O_APPEND is aligned to covers previous small appends
>    Append might happen via multiple files or via new file each time.
> 
> * mode vm.dirty_write_behind=1 ignores non-append writes
>    This reacts only to completely sequential writes like copying files,
>    writing logs with O_APPEND or rewriting files after O_TRUNC.
> 
> Note: ext4 feature "auto_da_alloc" also writes cache at closing file
> after truncating it to 0 and after renaming one file over other.
> 
> Changes since v1 (2017-10-02):
> * rework window management:
> * change default window 1MiB -> 16MiB
> * change default request 256KiB -> max_sectors_kb
> * drop always-async behavior for O_NONBLOCK
> * drop handling POSIX_FADV_NOREUSE (should be in separate patch)
> * ignore writes with O_DIRECT, O_SYNC, O_DSYNC
> * align head position for O_APPEND
> * add strictly sequential mode
> * write tail pages for new files
> * make void, keep errors at mapping
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Link: https://lore.kernel.org/patchwork/patch/836149/ (v1)
> ---

--------------2968E12483D6FA93813D5D46
Content-Type: application/x-shellscript;
 name="test_writebehind.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test_writebehind.sh"

bWtkaXIgLXAgd3JpdGViZWhpbmQudG1wCmNkIHdyaXRlYmVoaW5kLnRtcAoKTlI9MTAwCgpp
ZiBbICEgLWQgZHVtbXkgXSA7IHRoZW4KCW1rZGlyIGR1bW15Cglmb3IgaSBpbiAkKHNlcSAk
TlIpIDsgZG8KCQlzaXplX2tiPSRbJFJBTkRPTSAlIDY0ICogMTAyNF0KCQlkZCBpZj0vZGV2
L3plcm8gb2Y9ZHVtbXkvJGkgYnM9MTAyNCBjb3VudD0kc2l6ZV9rYgoJZG9uZQoJc3luYyAt
ZiAuCmZpCgplY2hvIFNJWkUKZHUgLXNoIGR1bW15Cgpmb3IgbW9kZSBpbiAwIDEgMjsgZG8K
CXN1ZG8gc3lzY3RsIHZtLmRpcnR5X3dyaXRlX2JlaGluZD0kbW9kZQoKCWVjaG8gQ09QWQoJ
dGltZSB0aW1lIGNwIC1yIGR1bW15IGNvcHkKCglncmVwIERpcnR5IC9wcm9jL21lbWluZm8K
CgllY2hvIFNZTkMKCXRpbWUgc3luYyAtZiBjb3B5CgoJcm0gLWZyIGNvcHkKZG9uZQo=
--------------2968E12483D6FA93813D5D46--
