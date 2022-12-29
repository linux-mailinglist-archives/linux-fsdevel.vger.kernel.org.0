Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754A2658A3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 09:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiL2ING (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 03:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiL2INE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:13:04 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DEB10040
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:12:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v23so18508829pju.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THv6prYzDq2eXsCiqs3MdATdHNqWI4kkKeIbH/Zad64=;
        b=kcc6RJTVV+2TkQyJSCeFHxHCvqGkX61fU5api+mTm4FoeljrR37YPZMYhuY7PSi34I
         dVzq3WHy0oVAErA1ntoAfenJREFeiWAPXvpomnDmICPC7Lsjk2Iqk1e5hs4pz3lteU9e
         gJktCqLkel+nkfKGeyyzLk2ONLcRio7yg64ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THv6prYzDq2eXsCiqs3MdATdHNqWI4kkKeIbH/Zad64=;
        b=SPv1g5LD92SbP592U7Alfm5WrIHqvlfiglvct9vIPkDtL/D7jDOhncfTnA6WxOOXQE
         HILJBi0ksa+h5mNXAESqNJA2HdOVyXh0EYvPDW4ElTioNvKqu3gsCWO2wjlNMIVlz0aI
         lbqs00CQRUNhpVKV8GH5AN+RGrnbwKBtBcjFxLoJY3S9nRAHNcIT/hGCl6uqoBA/t/32
         YUW9PyAE2eV8kh3li3cqIX+VVC8uVUICiCWuQ2SSaH26Wqv7uQWEoPca+Qo2c9ijRl0O
         /+NPe7ryXFSUk8MmNmaqatJWf14N72DMDZPQ//BfAJYtUuG7bqqT8SMDoKsOoUl07lGg
         nEjg==
X-Gm-Message-State: AFqh2kq/M3dPUdW520dNiNVPA7VWHTa/kBxxZ6ZdqSCOpM/BkRsrVJk2
        GgDtZho1o5PRRunet8bVw1r9Fw==
X-Google-Smtp-Source: AMrXdXu9lcGIP5E+xv/lfVaOI7oGNaTa8ZYVW9/FVtdg5eoc6mZA7pS4ycv7ew5XN0iSQz9w8aYiWA==
X-Received: by 2002:a05:6a21:3a46:b0:9f:3197:bfa1 with SMTP id zu6-20020a056a213a4600b0009f3197bfa1mr40455755pzb.7.1672301579046;
        Thu, 29 Dec 2022 00:12:59 -0800 (PST)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:75ff:1277:3d7b:d67a])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b00192820d00d0sm6496325plk.120.2022.12.29.00.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:12:58 -0800 (PST)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 0/8] Introduce provisioning primitives for thinly provisioned storage
Date:   Thu, 29 Dec 2022 00:12:45 -0800
Message-Id: <20221229081252.452240-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This patch series adds a mechanism to pass through provision requests on
stacked thinly provisioned storage devices/filesystems.

The linux kernel provides several mechanisms to set up thinly provisioned
block storage abstractions (eg. dm-thin, loop devices over sparse files),
either directly as block devices or backing storage for filesystems. Currently,
short of writing data to either the device or filesystem, there is no way for
users to pre-allocate space for use in such storage setups. Consider the
following use-cases:

1) Suspend-to-disk and resume from a dm-thin device: In order to ensure that
   the underlying thinpool metadata is not modified during the suspend
   mechanism, the dm-thin device needs to be fully provisioned.
2) If a filesystem uses a loop device over a sparse file, fallocate() on the
   filesystem will allocate blocks for files but the underlying sparse file
   will remain intact.
3) Another example is virtual machine using a sparse file/dm-thin as a storage
   device; by default, allocations within the VM boundaries will not affect
   the host.
4) Several storage standards support mechanisms for thin provisioning on
   real hardware devices. For example:
   a. The NVMe spec 1.0b section 2.1.1 loosely talks about thin provisioning:
      "When the THINP bit in the NSFEAT field of the Identify Namespace data
       structure is set to ‘1’, the controller ... shall track the number of
       allocated blocks in the Namespace Utilization field"
   b. The SCSi Block Commands reference - 4 section references "Thin
      provisioned logical units",
   c. UFS 3.0 spec section 13.3.3 references "Thin provisioning".

In all the above situations, currently, the only way for pre-allocating space
is to issue writes (or use WRITE_ZEROES/WRITE_SAME). However, that does not
scale well with larger pre-allocation sizes.

This patchset introduces primitives to support block-level provisioning (note:
the term 'provisioning' is used to prevent overloading the term
'allocations/pre-allocations') requests across filesystems and block devices.
This allows fallocate() and file creation requests to reserve space across
stacked layers of block devices and filesystems. Currently, the patchset covers
a prototype on the device-mapper targets, loop device and ext4, but the same
mechanism can be extended to other filesystems/block devices as well as extended
for use with devices in 4 a-c.

Patch 1 introduces REQ_OP_PROVISION as a new request type.
The provision request acts like the inverse of a discard request; instead
of notifying lower layers that the block range will no longer be used, provision
acts as a request to lower layers to provision disk space for the given block
range. Real hardware storage devices will currently disable the provisioing
capability but for the standards listed in 4a.-c., REQ_OP_PROVISION can be
overloaded for use as the provisioing primitive for future devices.

Patch 2 implements REQ_OP_PROVISION handling for some of the device-mapper
targets. This additionally adds support for pre-allocating space for thinly
provisioned logical volumes via fallocate()

Patch 3 introduces an fallocate() mode (FALLOC_FL_PROVISION) that sends a
provision request to the underlying block device (and beyond). This acts as the
primary mechanism for file provisioning as well as disambiguates the notion of
virtual and true disk space allocations for thinly provisioned storage devices/
filesystems. With patch 3, the 'default' fallocate() mode is preserved to
perform preallocation at the current allocation layer and 'provision' mode
adds the capability to punch through the allocations to the underlying thinly
provisioned storage layers. For regular filesystems, both allocation modes
are equivalent.

Patch 4 wires up the loop device handling of REQ_OP_PROVISION.

Patches 5-7 cover a prototype implementation for ext4, which includes wiring up
the fallocate() implementation, introducing a filesystem level option (called
'provision') to control the default allocation behaviour and, finally, a
file-level override to retain current handling, even on filesystems mounted with
'provision'. These options allow users of stacked filesystems to flexibly take
advantage of provisioning.

Testing:
--------
- Tested on a VM running a 6.2 kernel.
- The following perfomrmance measurements were collected with fallocate(2)
patched to add support for FALLOC_FL_PROVISION via a command line option 
`-p/--provision`.

- Preallocation of dm-thin devices:
As expected, avoiding the need to zero out thinly-provisioned block devices to
preallocate space speeds up the provisioning operation significantly:

The following was tested on a dm-thin device set up on top of a dm-thinp with
skip_block_zeroing=true.
A) Zeroout was measured using `fallocate -z ...`
B) Provision was measured using `fallocate -p ...`.

Size    Time     A	B
512M    real     1.093  0.034
        user     0      0
        sys      0.022  0.01
1G      real     2.182  0.048
        user     0      0.01
        sys      0.022  0
2G      real     4.344  0.082
        user     0      0.01
        sys      0.036  0
4G      real     8.679  0.153
        user     0      0.01
        sys      0.073  0
8G      real    17.777  0.318
        user     0      0.01
        sys      0.144  0

- Preallocation of files on filesystems
Since fallocate() with FALLOC_FL_PROVISION can now pass down through
filesystems/block devices, this results in an expected slowdown in fallocate()
calls if the provision request is sent to the underlying layers.

The measurements were taken using fallocate() on ext4 filesystems set up with
the following opts/block devices:
A) ext4 filesystem mounted with 'noprovision'
B) ext4 filesystem mounted with 'provision' on a dm-thin device.
C) ext4 filesystem mounted with 'provision' on a loop device with a sparse
   backing file on the filesystem in (B).

Size	Time	A	B	C
512M	real	0.011	0.036	0.041
	user	0.02	0.03	0.002
	sys	0	0	0
1G	real	0.011	0.055	0.064
	user	0	0	0.03
	sys	0.003	0.004	0
2G	real	0.011	0.109	0.117
	user	0	0	0.004
	sys	0.003	0.006	0
4G	real	0.011	0.224	0.231
	user	0	0	0.006
	sys	0.004	0.012	0
8G	real	0.017	0.426	0.527
	user	0	0	0.013
	sys	0.009	0.024	0

As expected, the additional provision requests will slow down fallocate() calls
and the degree of slowdown depends on the number of layers that the provision
request is passed through to as well as the complexity of allocation on those
layers.

TODOs:
------
- Xfstests for validating provisioning results in allocation.

Changelog:

V2:
- Fix stacked limit handling.
- Enable provision request handling in dm-snapshot
- Don't call truncate_bdev_range if blkdev_fallocate() is called with
  FALLOC_FL_PROVISION.
- Clarify semantics of FALLOC_FL_PROVISION and why it needs to be a separate flag
  (as opposed to overloading mode == 0).
