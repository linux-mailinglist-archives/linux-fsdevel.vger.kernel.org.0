Return-Path: <linux-fsdevel+bounces-77745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFZnO6SIl2nOzwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:03:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E85016305A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09982303A118
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BEA32AACF;
	Thu, 19 Feb 2026 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuB9Er+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062D1DE3B5;
	Thu, 19 Feb 2026 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771538584; cv=none; b=NomrDCjVXqEARQnriR6VlsMdMVtq0xN9SFa9rTXQmlouoBrY+MEKLYi/bvrB7cHG1GpgJYWyH2JgB/zwjUJ61m7hrWmfiMle9E71Jf5Q5oQfc0tIfnqz2qq7W7yssaQ/Rs9Z9H7ULILD8kpej6MHc4iwFOPivsEQTRHyu23eC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771538584; c=relaxed/simple;
	bh=zm7tljVg2N96+9a1lK93sXU3p5uQd1hLQmRQAJ+hPXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8ZseLAsqH2Pjnr5T3WtWkYwwsIShYFnr5o97AayKqFxlc5z52tWG6pb4lGko0Pd/mXWgzNQpc995jf632NQ4ikc1y4CjRPOyxMOjE6tAbScVnnwFjcXaUG8akyJBbkMXwh1Y5nCDPBOGWWcwPQBT+V75iBSJb3TeObHuULxYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuB9Er+B; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771538583; x=1803074583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zm7tljVg2N96+9a1lK93sXU3p5uQd1hLQmRQAJ+hPXk=;
  b=AuB9Er+BCTGzTFGG25/Q1vxSpw8aHERxfkmZCUCwT7gykrqrDOm9G0xq
   Npg5w1lVJ/6G4o368RBXyUFMUdc8PsQhy/11bxrH9yXx/i8v9fja0lnIU
   QqMmlMPBdd1Ww/MdMQ2DlSWJpUP+T4hpvcYBJraWuRjDN5z/AC3okcXX3
   OjTlCOHCCVTh6dizx1SwjkaBNUL9YtbtoHiWi1ZnGboJe28CP/8PjWPmO
   uY88JB+v7hlMOOPAjfwNuEL0wmESbun2AxTvFhvtaVFjS3X7Tlw+7yT43
   +0CqlABZACIuWYpc4wQTRE6OaIrFLwNbybWMJWVoMOBKuwHMQUtxDOUHS
   w==;
X-CSE-ConnectionGUID: kgatIXKrRwa+WIWqhn6rsg==
X-CSE-MsgGUID: 6oK6IJxZQmK6ad22hZSJdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83743257"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="83743257"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 14:03:02 -0800
X-CSE-ConnectionGUID: kewWB6PVTaG7FYVO+Xs4Gw==
X-CSE-MsgGUID: QcuqasHkQfON1gxT8izJuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="252353507"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 14:02:59 -0800
Message-ID: <fc271da5-757b-4fb9-a42b-85a7a38e4343@intel.com>
Date: Thu, 19 Feb 2026 15:02:57 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] Add test/daxctl-famfs.sh to test famfs mode
 transitions:
To: John Groves <john@jagalactic.com>, John Groves <John@Groves.net>,
 Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>,
 Bernd Schubert <bschubert@ddn.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 David Hildenbrand <david@kernel.org>, Christian Brauner
 <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong
 <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>,
 Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>,
 Ajay Joshi <ajayjoshi@micron.com>,
 "venkataravis@micron.com" <venkataravis@micron.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <0100019bd34040d9-0b6e9e4c-ecd4-464d-ab9d-88a251215442-000000@email.amazonses.com>
 <20260118223640.92878-1-john@jagalactic.com>
 <0100019bd340f73c-90b0fafb-786e-4368-85f0-149ffa1d637a-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019bd340f73c-90b0fafb-786e-4368-85f0-149ffa1d637a-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[micron.com,fastmail.com,lwn.net,intel.com,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-77745-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[daxctl-famfs.sh:url,intel.com:mid,intel.com:dkim,groves.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mmap.sh:url]
X-Rspamd-Queue-Id: 4E85016305A
X-Rspamd-Action: no action



On 1/18/26 3:36 PM, John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> - devdax <-> famfs mode switches
> - Verify famfs -> system-ram is rejected (must go via devdax)
> - Test JSON output shows correct mode
> - Test error handling for invalid modes
> 
> The test is added to the destructive test suite since it
> modifies device modes.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  test/daxctl-famfs.sh | 253 +++++++++++++++++++++++++++++++++++++++++++
>  test/meson.build     |   2 +
>  2 files changed, 255 insertions(+)
>  create mode 100755 test/daxctl-famfs.sh
> 
> diff --git a/test/daxctl-famfs.sh b/test/daxctl-famfs.sh
> new file mode 100755
> index 0000000..12fbfef
> --- /dev/null
> +++ b/test/daxctl-famfs.sh
> @@ -0,0 +1,253 @@
> +#!/bin/bash -Ex
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2025 Micron Technology, Inc. All rights reserved.
> +#
> +# Test daxctl famfs mode transitions and mode detection
> +
> +rc=77
> +. $(dirname $0)/common
> +
> +trap 'cleanup $LINENO' ERR
> +
> +daxdev=""
> +original_mode=""
> +
> +cleanup()
> +{
> +	printf "Error at line %d\n" "$1"
> +	# Try to restore to original mode if we know it
> +	if [[ $daxdev && $original_mode ]]; then
> +		"$DAXCTL" reconfigure-device -f -m "$original_mode" "$daxdev" 2>/dev/null || true
> +	fi
> +	exit $rc
> +}
> +
> +# Check if fsdev_dax module is available
> +check_fsdev_dax()
> +{
> +	if modinfo fsdev_dax &>/dev/null; then
> +		return 0
> +	fi
> +	if grep -qF "fsdev_dax" "/lib/modules/$(uname -r)/modules.builtin" 2>/dev/null; then
> +		return 0
> +	fi
> +	printf "fsdev_dax module not available, skipping\n"
> +	exit 77
> +}

Wonder if a common bash function can be created for this and put in "common"

check_kmod_available()?

DJ

> +
> +# Check if kmem module is available (needed for system-ram mode tests)
> +check_kmem()
> +{
> +	if modinfo kmem &>/dev/null; then
> +		return 0
> +	fi
> +	if grep -qF "kmem" "/lib/modules/$(uname -r)/modules.builtin" 2>/dev/null; then
> +		return 0
> +	fi
> +	printf "kmem module not available, skipping system-ram tests\n"
> +	return 1
> +}
> +
> +# Find an existing dax device to test with
> +find_daxdev()
> +{
> +	# Look for any available dax device
> +	daxdev=$("$DAXCTL" list | jq -er '.[0].chardev // empty' 2>/dev/null) || true
> +
> +	if [[ ! $daxdev ]]; then
> +		printf "No dax device found, skipping\n"
> +		exit 77
> +	fi
> +
> +	# Save the original mode so we can restore it
> +	original_mode=$("$DAXCTL" list -d "$daxdev" | jq -er '.[].mode')
> +
> +	printf "Found dax device: %s (current mode: %s)\n" "$daxdev" "$original_mode"
> +}
> +
> +daxctl_get_mode()
> +{
> +	"$DAXCTL" list -d "$1" | jq -er '.[].mode'
> +}
> +
> +# Ensure device is in devdax mode for testing
> +ensure_devdax_mode()
> +{
> +	local mode
> +	mode=$(daxctl_get_mode "$daxdev")
> +
> +	if [[ "$mode" == "devdax" ]]; then
> +		return 0
> +	fi
> +
> +	if [[ "$mode" == "system-ram" ]]; then
> +		printf "Device is in system-ram mode, attempting to convert to devdax...\n"
> +		"$DAXCTL" reconfigure-device -f -m devdax "$daxdev"
> +	elif [[ "$mode" == "famfs" ]]; then
> +		printf "Device is in famfs mode, converting to devdax...\n"
> +		"$DAXCTL" reconfigure-device -m devdax "$daxdev"
> +	else
> +		printf "Device is in unknown mode: %s\n" "$mode"
> +		return 1
> +	fi
> +
> +	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
> +}
> +
> +#
> +# Test basic mode transitions involving famfs
> +#
> +test_famfs_mode_transitions()
> +{
> +	printf "\n=== Testing famfs mode transitions ===\n"
> +
> +	# Ensure starting in devdax mode
> +	ensure_devdax_mode
> +	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
> +	printf "Initial mode: devdax - OK\n"
> +
> +	# Test: devdax -> famfs
> +	printf "Testing devdax -> famfs... "
> +	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
> +	[[ $(daxctl_get_mode "$daxdev") == "famfs" ]]
> +	printf "OK\n"
> +
> +	# Test: famfs -> famfs (re-enable in same mode)
> +	printf "Testing famfs -> famfs (re-enable)... "
> +	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
> +	[[ $(daxctl_get_mode "$daxdev") == "famfs" ]]
> +	printf "OK\n"
> +
> +	# Test: famfs -> devdax
> +	printf "Testing famfs -> devdax... "
> +	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
> +	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
> +	printf "OK\n"
> +
> +	# Test: devdax -> devdax (re-enable in same mode)
> +	printf "Testing devdax -> devdax (re-enable)... "
> +	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
> +	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
> +	printf "OK\n"
> +}
> +
> +#
> +# Test mode transitions with system-ram (requires kmem)
> +#
> +test_system_ram_transitions()
> +{
> +	printf "\n=== Testing system-ram transitions with famfs ===\n"
> +
> +	# Ensure we start in devdax mode
> +	ensure_devdax_mode
> +	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
> +
> +	# Test: devdax -> system-ram
> +	printf "Testing devdax -> system-ram... "
> +	"$DAXCTL" reconfigure-device -N -m system-ram "$daxdev"
> +	[[ $(daxctl_get_mode "$daxdev") == "system-ram" ]]
> +	printf "OK\n"
> +
> +	# Test: system-ram -> famfs should fail
> +	printf "Testing system-ram -> famfs (should fail)... "
> +	if "$DAXCTL" reconfigure-device -m famfs "$daxdev" 2>/dev/null; then
> +		printf "FAILED - should have been rejected\n"
> +		return 1
> +	fi
> +	printf "OK (correctly rejected)\n"
> +
> +	# Test: system-ram -> devdax -> famfs (proper path)
> +	printf "Testing system-ram -> devdax -> famfs... "
> +	"$DAXCTL" reconfigure-device -f -m devdax "$daxdev"
> +	[[ $(daxctl_get_mode "$daxdev") == "devdax" ]]
> +	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
> +	[[ $(daxctl_get_mode "$daxdev") == "famfs" ]]
> +	printf "OK\n"
> +
> +	# Restore to devdax for subsequent tests
> +	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
> +}
> +
> +#
> +# Test JSON output shows correct mode
> +#
> +test_json_output()
> +{
> +	printf "\n=== Testing JSON output for mode field ===\n"
> +
> +	# Test devdax mode in JSON
> +	ensure_devdax_mode
> +	printf "Testing JSON output for devdax mode... "
> +	mode=$("$DAXCTL" list -d "$daxdev" | jq -er '.[].mode')
> +	[[ "$mode" == "devdax" ]]
> +	printf "OK\n"
> +
> +	# Test famfs mode in JSON
> +	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
> +	printf "Testing JSON output for famfs mode... "
> +	mode=$("$DAXCTL" list -d "$daxdev" | jq -er '.[].mode')
> +	[[ "$mode" == "famfs" ]]
> +	printf "OK\n"
> +
> +	# Restore to devdax
> +	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
> +}
> +
> +#
> +# Test error messages for invalid transitions
> +#
> +test_error_handling()
> +{
> +	printf "\n=== Testing error handling ===\n"
> +
> +	# Ensure we're in famfs mode
> +	"$DAXCTL" reconfigure-device -m famfs "$daxdev"
> +
> +	# Test that invalid mode is rejected
> +	printf "Testing invalid mode rejection... "
> +	if "$DAXCTL" reconfigure-device -m invalidmode "$daxdev" 2>/dev/null; then
> +		printf "FAILED - invalid mode should be rejected\n"
> +		return 1
> +	fi
> +	printf "OK (correctly rejected)\n"
> +
> +	# Restore to devdax
> +	"$DAXCTL" reconfigure-device -m devdax "$daxdev"
> +}
> +
> +#
> +# Main test sequence
> +#
> +main()
> +{
> +	check_fsdev_dax
> +	find_daxdev
> +
> +	rc=1  # From here on, failures are real failures
> +
> +	test_famfs_mode_transitions
> +	test_json_output
> +	test_error_handling
> +
> +	# System-ram tests require kmem module
> +	if check_kmem; then
> +		# Save and disable online policy for system-ram tests
> +		saved_policy="$(cat /sys/devices/system/memory/auto_online_blocks)"
> +		echo "offline" > /sys/devices/system/memory/auto_online_blocks
> +
> +		test_system_ram_transitions
> +
> +		# Restore online policy
> +		echo "$saved_policy" > /sys/devices/system/memory/auto_online_blocks
> +	fi
> +
> +	# Restore original mode
> +	printf "\nRestoring device to original mode: %s\n" "$original_mode"
> +	"$DAXCTL" reconfigure-device -f -m "$original_mode" "$daxdev"
> +
> +	printf "\n=== All famfs tests passed ===\n"
> +
> +	exit 0
> +}
> +
> +main
> diff --git a/test/meson.build b/test/meson.build
> index 615376e..ad1d393 100644
> --- a/test/meson.build
> +++ b/test/meson.build
> @@ -209,6 +209,7 @@ if get_option('destructive').enabled()
>    device_dax_fio = find_program('device-dax-fio.sh')
>    daxctl_devices = find_program('daxctl-devices.sh')
>    daxctl_create = find_program('daxctl-create.sh')
> +  daxctl_famfs = find_program('daxctl-famfs.sh')
>    dm = find_program('dm.sh')
>    mmap_test = find_program('mmap.sh')
>  
> @@ -226,6 +227,7 @@ if get_option('destructive').enabled()
>      [ 'device-dax-fio.sh', device_dax_fio, 'dax'   ],
>      [ 'daxctl-devices.sh', daxctl_devices, 'dax'   ],
>      [ 'daxctl-create.sh',  daxctl_create,  'dax'   ],
> +    [ 'daxctl-famfs.sh',   daxctl_famfs,   'dax'   ],
>      [ 'dm.sh',             dm,		   'dax'   ],
>      [ 'mmap.sh',           mmap_test,	   'dax'   ],
>    ]


