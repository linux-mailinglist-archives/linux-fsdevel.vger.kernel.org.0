Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A167B58DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 19:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbjJBRDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 13:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbjJBRDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:03:04 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EC5BF;
        Mon,  2 Oct 2023 10:03:02 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-69101022969so14987130b3a.3;
        Mon, 02 Oct 2023 10:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266182; x=1696870982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rgW1P/kbPRRjPU2p9ZFV6J7W8Gynjv0+wqv7Y18r3U=;
        b=qpdHFZsecS7UTg5FAy2rJ+jycK0xTrBeBav0i4i0tNzNW7CzlCCEbHx0DHPRx9Ck4r
         Gzd67VZjbbXtUAybMjNhXP7PDny4PBmjlw1Vptk7Z6slBhcJXcKc9ROMDsr1J0waCcPS
         XEFi333SCNEL+3uJKh/bPGmNpPwGPEKgGE6CdIj8Lsg0u4oLro6PJzIF6U448CaTZFAF
         Ig0s63Q5dy7Ij/6JInhWGla7Pb+88mLtBzw1r/xLNkEe6r9jykQ18RGNuxoOiDi6HDVO
         I8/INThqEzHIdaqOkQvG5/R1Nv69deEXP3uqTYWg+HkJUm0C86RSKRfxZtX4vmIZQUGy
         mhGw==
X-Gm-Message-State: AOJu0Yy4sYrn51YFpMeJAbjkMWkQ0aBNxzJQ854FpWmwi/HZAED0zeVz
        2/kA/V5ogXoPrUmSRT80AVb06rh7kzo=
X-Google-Smtp-Source: AGHT+IGyYr19Sl3Lhb6nq16oygKsbBzpUV8uwf2c0t5ClepWOQiK6E2Pj5bDYZYKyWtiFZA+hMZsqw==
X-Received: by 2002:a05:6a00:24c8:b0:692:a727:1fdd with SMTP id d8-20020a056a0024c800b00692a7271fddmr15279022pfv.4.1696266181593;
        Mon, 02 Oct 2023 10:03:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6ad7:f663:5f97:db57? ([2620:15c:211:201:6ad7:f663:5f97:db57])
        by smtp.gmail.com with ESMTPSA id u19-20020aa78493000000b006933e71956dsm8786432pfn.9.2023.10.02.10.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 10:03:01 -0700 (PDT)
Message-ID: <3780fa8e-bdad-40b3-853d-e24fe25e8a94@acm.org>
Date:   Mon, 2 Oct 2023 10:02:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] block: Restore write hint support
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-5-bvanassche@acm.org>
 <DM6PR04MB65759F0790E391DC7D5D8139FCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB65759F0790E391DC7D5D8139FCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/2/23 04:23, Avri Altman wrote:
>> The following aspects of that commit have been dropped:
>> - Debugfs support for retrieving and modifying write hints.
> 
> Any particular reason to left those out?

The above comment is misleading: what has not been restored is the
struct request_queue write_hints[] array member nor the debugfs
interface for accessing that array. My understanding is that that array
was used to track stream statistics by the NVMe driver. From version
v5.17 of the NVMe driver:

	if (streamid < ARRAY_SIZE(req->q->write_hints))
		req->q->write_hints[streamid] += blk_rq_bytes(req) >> 9;

>> - md-raid, BTRFS, ext4, gfs2 and zonefs write hint support.
> 
> Native Linux with ext4 is being used in automotive, and even mobile
> platforms. E.g. Qualcomm's RB5 is formally maintained with Debian -
> https://releases.linaro.org/96boards/rb5/linaro/debian/21.12/

All ext4 did with write hint information is to copy the inode write
hint information into the bio. The inode write hint information is set
by the F_SET_RW_HINT fcntl. The only software packages that use the
F_SET_RW_HINT fcntl and that I'm aware of are RocksDB, Samba, stress_ng
and rr. Are any of these software packages used in automotive software
on top of ext4?

Thanks,

Bart.
