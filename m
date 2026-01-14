Return-Path: <linux-fsdevel+bounces-73662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D58D1E82D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2A2D3032CF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82F9396B6F;
	Wed, 14 Jan 2026 11:47:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBA6343D8F;
	Wed, 14 Jan 2026 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391250; cv=none; b=EU2F/zURrmovNvg14TTMdfP6Mddr9lXViqjBXjj5e2sF31ZiXMPPkwmumQc5+zxZxjloyijiQ4EJkYjrdRQfq56T66U9vv/0IUX5MiVeJRu9Aab/4RHcMFE87ijSp/R/C80nd5cB61VFwNQlUSSU/X4IIVrIx2SOfrwzqzecHR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391250; c=relaxed/simple;
	bh=tRmJmq0DwJjk8bbEa3VCzzxzz4BRiEPaWxOUDfrzLz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dD2+JWYxMsshXl5CsjyNCNhujHEO3q8uktinh+JOme1K/uUhYjcCjNE8YFLXCdvXbAb7pYIuUrs7jNUKANH6cg562mdRLeX+cQe/4QaT/Cp5805YpOh2u5BC2Je17EqZsvp4j7i0cGdAfT3aOy+e5eRrTRkOPSP5aXZjPu/GCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43078339;
	Wed, 14 Jan 2026 03:47:14 -0800 (PST)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49D523F59E;
	Wed, 14 Jan 2026 03:47:17 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	jonathan.cameron@huawei.com,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 00/17] Introduce SCMI Telemetry FS support
Date: Wed, 14 Jan 2026 11:46:04 +0000
Message-ID: <20260114114638.2290765-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

the upcoming SCMI v4.0 specification [0] introduces a new SCMI protocol
dedicated to System Telemetry.

In a nutshell, the SCMI Telemetry protocol allows an agent to discover at
runtime the set of Telemetry Data Events (DEs) available on a specific
platform and provides the means to configure the set of DEs that a user is
interested into, while reading them back using the collection method that
is deeemd more suitable for the usecase at hand. (amongst the various
collection methods allowed by SCMI specification)

Without delving into the gory details of the whole SCMI Telemetry protocol
let's just say that the SCMI platform firmware advertises a number of
Telemetry Data Events, each one identified by a 32bit unique ID, and an
agent, like Linux, can discover them and read back at will the associated
data value in a number of ways.
Data collection is mainly intended to happen on demand via shared memory
areas exposed by the platform firmware, discovered dynamically via SCMI
Telemetry and accessed by Linux on-demand, but some DE can also be reported
via SCMI Notifications or direct dedicated FastChannels (another kind of
SCMI MMIO): all of this underlying mechanism is anyway hidden to the user
since it is mediated by the kernel which will return the proper data value
when queried.

Anyway, the set of well-known architected DE IDs defined by the spec is
limited to a dozen IDs, which means that the vast majority of DE IDs are
customizable per-platform: as a consequence the same ID, say '0x1234',
could represent completely different things on different systems.

Precise definitions and semantic of such custom Data Event IDs are out of
the scope of the SCMI Telemetry specification and of this implementation:
they are supposed to be provided using some kind of JSON-like description
file that will have to be consumed by a userspace tool which would be
finally in charge of making sense of the set of available DEs.

IOW, in turn, this means that even though the DEs enumerated via SCMI come
with some sort of topological and qualitative description provided by the
protocol (like unit of measurements, name, topology info etc), kernel-wise
we CANNOT be completely sure of "what is what" without being fed-back some
sort of information about the DEs by the above mentioned userspace tool.

For these reasons, currently this series does NOT attempt to register any
of these DEs with any of the usual in-kernel subsystems (like HWMON IIO,
PERF etc), simply because we cannot be sure which DE is suitable or even
desirable for a given subsystem. This also means there are NO in-kernel
users of these Telemetry data events as of now.

So, while we do not exclude, in the future, to feed/register some of the
discovered DEs with some of the above mentioned Kernel subsystems, as of
now we have ONLY modeled a custom userspace API to make SCMI Telemetry
available to userspace tools.

In deciding which kind of interface to expose SCMI Telemetry data to a
user, this new SCMI Telemetry driver aims at satisfying 2 main reqs:

 - exposing some sort of FS-based human-readable interface that can be used
   to discover, configure and access our Telemetry data directly from the
   shell

 - exposing alternative machine-friendly, more-performant, binary
   interfaces that can be used to avoid the overhead of multiple accesses
   to the VFS and that can be more suitable to be accessed with a custom
   tool

In the initial RFC posted a few months ago [2], the above was achieved
with a combination of a SysFS interface, for the human-readable side of
the story, and a classic chardev/ioctl for the plain binary access.

Since V1, instead, we moved away from this combined approach, especially
away from SysFS, for the following reason:

 1. "Abusing SysFS": SysFS is a handy way to expose device related
      properties in a common way, using a few common helpers built on
      kernfs; this means, though, that unfortunately in our scenario I had
      to generate a dummy simple device for EACH SCMI Telemetry DataEvent
      that I got to discover at runtime and attach to them, all of the
      properties I need.
      This by itself seemed to me abusing the SysFS framework, but even
      ignoring this, the impact on the system when we have to deal with
      hundreds or tens of thousands od DEs is sensible.
      In some test scenario I ended with 50k devices and half-a-millon
      related property files ... O_o

 2. "SysFS constraints": SysFS usage itself has its well-known constraints
      and best practices, like the one-file/one-value rule, and due to the
      fact that any virtual file with a complex structure or handling logic
      is frowned upon, you can forget about IOTCLs and mmap'ing to provide
      a more performant interface, which is the reason why, in the previous
      RFC, there was an additional alternative chardev interface.
      These latter limitations around the implementation of files with a
      more complex semantic (i.e. with a broader set of file_operations)
      derive from the underlying KernFS support, so KernFS is equally not
      suitable as a building block for our implementation.

 2. "Chardev limitations": Given the nature of the protocol, the hybrid
      approach employing character devices was itself problematic: first
      of all because there is an upper limit on the number of chardev we
      can create, dictated by the range of available minor numbers and
      then because the fact itself to have to maintain 2 completely
      different interfaces (FS + chardev) is a pain.

As a final remark, please NOTE THAT all of this is supposed to be available
in production systems across a number of heterogeneous platforms: for these
reasons the easy choice, debugFS, is not an option.

Due to the above reasoning, since V1 we opted for a new approach with the
proposed interfaces now based on a full fledged, unified, virtual pseudo
filesystem implemented from scratch so that we can:

 - expose all the DEs property we like as before with SysFS, but without
   any of the constraint imposed by the usage of SysFs or kernfs.

 - easily expose additional alternative views of the same set of DEs
   using symlinking capabilities (e.g. alternative topological view)

 - additionally expose a few alternative and more performant interfaces
   by embedding in that same FS, a few special virtual files:

   + 'control': to issue IOCTLs for quicker discovery and on-demand access
   		to data
   + 'pipe' [TBD]: to provide a stream of events using a virtual
		   infinite-style file
   + 'raw_<N>' [TBD]: to provide direct memory mapped access to the raw
   		      SCMI Telemetry data

 - use a mount option to enable a lazy enumeration operation mode to delay
   SCMI related background discovery activities to the effective point in
   time when the user needs it (if ever)


INTERFACES
===========

We propose a couple of interfaces, both rooted in the same unified
SCMI Telemetry Filesystem STLMFS, which can be mounted with:

	mount -t stlmfs none /sys/fs/arm_telemetry/

In a nutshell, we expose the following interfaces, rooted at different
points in the FS:

 1. a FS based human-readable API tree

   This API present the discovered DEs and DEs-groups rooted under a
   structrure like this:

	/sys/fs/arm_telemetry/tlm_0/
	|-- all_des_enable
	|-- all_des_tstamp_enable
	|-- available_update_intervals_ms
	|-- current_update_interval_ms
	|-- de_implementation_version
	|-- des
	|   |-- 0x00000000
	|   |-- 0x00000016
	|   |-- 0x00001010
	|   |-- 0x0000A000
	|   |-- 0x0000A001
	|   |-- 0x0000A002
	|   |-- 0x0000A005
	|   |-- 0x0000A007
	|   |-- 0x0000A008
	|   |-- 0x0000A00A
	|   |-- 0x0000A00B
	|   |-- 0x0000A00C
	|   `-- 0x0000A010
	|-- des_bulk_read
	|-- des_single_sample_read
	|-- groups
	|   |-- 0
	|   `-- 1
	|-- intervals_discrete
	|-- reset
	|-- tlm_enable
	`-- version

	At the top level we have general configuration knobs to:

	- enable/disable all DEs with or without tstamp
	- configure the update interval that the platform will use
	- enable Telemetry as a whole rest the whole stack
	- read all the enabled DEs in a buffer one-per-line
		<DE_ID> <TIMESTAMP> <DATA_VALUE>
	- des_single_sample_read to request an immediate updated read of
	  all the enabled DEs in a single buffer one-per-line:
		<DE_ID> <TIMESTAMP> <DATA_VALUE>
        
	where each DE in turn is represented by a flat subtree like:

	tlm_0/des/0xA001/
	|-- compo_instance_id
	|-- compo_type
	|-- enable
	|-- instance_id
	|-- name
	|-- persistent
	|-- tstamp_enable
	|-- tstamp_exp
	|-- type
	|-- unit
	|-- unit_exp
	`-- value

	where, beside a bunch of description items, you can:

	- enable/disable a single DE
	- read back its tstamp and data from 'value' as in:
		<TIMESTAMP>: <DATA_VALUE>

	then for each discovered group of DEs:

	scmi_tlm_0/groups/0/
	|-- available_update_intervals_ms
	|-- composing_des
	|-- current_update_interval_ms
	|-- des_bulk_read
	|-- des_single_sample_read
	|-- enable
	|-- intervals_discrete
	`-- tstamp_enable

	you can find the knobs to:
	
	- enable/disable the group as a whole
	- lookup group composition
	- set a per-group update interval (if supported)
	- des_bulk_read to read all the enabled DEs for this group in a
	  single buffer one-per-line:
		<DE_ID> <TIMESTAMP> <DATA_VALUE>
	- des_single_sample_read to request an immediate updated read of
	  all the enabled DEs for this group in a single buffer
	  one-per-line:
		<DE_ID> <TIMESTAMP> <DATA_VALUE>

 2. Leveraging the capabilities of a full-fledged filesystem and the
    topological information provided by SCMI Telemetry we expose also
    and alternative view of the above tree, by symlinking a few of the
    same entries above under another, topologically sorted, subtree:

    components/
    |-- cpu
    |   |-- 0
    |   |   |-- celsius
    |   |   |   `-- 0
    |   |   |       `-- 0x0001
    |   |   |           |-- compo_instance_id
    |   |   |           |-- compo_type
    |   |   |           |-- enable
    |   |   |           |-- instance_id
    |   |   |           |-- name
    |   |   |           |-- persistent
    |   |   |           |-- tstamp_enable
    |   |   |           |-- tstamp_exp
    |   |   |           |-- type
    |   |   |           |-- unit
    |   |   |           |-- unit_exp
    |   |   |           `-- value
    |   |   `-- cycles
    |   |       |-- 0
    |   |       |   `-- 0x1010
    |   |	    |    ....
	.................
	...............
    |   |-- 1
    |   |   `-- celsius
    |   |       `-- 0
    |   |           `-- 0x0002
    |   |           .........
    |   `-- 2
    |       `-- celsius
    |           `-- 0
    |               `-- 0x0003
    |-- interconnnect
    |   `-- 0
    |       `-- hertz
    |           `-- 0
    |               |-- 0xA008
    |               `-- 0xA00B
    |-- mem_cntrl
    |   `-- 0
    |       |-- bps
    |       |   `-- 0
    |       |       `-- 0xA00A
    |       |-- celsius
    |       |   `-- 0
    |       |       `-- 0xA007
    |       `-- joules
    |           `-- 0
    |               `-- 0xA002
    |-- periph
    |   |-- 0
    |   |   `-- messages
    |   |       `-- 0
    |   |           `-- 0x0016
    |   |-- 1
    |   |   `-- messages
    |   |       `-- 0
    |   |           `-- 0x0017
    |   `-- 2
    |       `-- messages
    |           `-- 0
    |               `-- 0x0018
    `-- unspec
    `-- 0
    |-- celsius
    |   `-- 0
    |       `-- 0xA005


   ...so as to provide the human user with a more understandable layout.


All of this is nice and fancy human-readable, easily scriptable, but
certainly not the fastest possible to access especially on huge trees...

 ... so for the afore-mentioned reasons we alternatively expose also:

 3. a more performant API based on IOCTLs as described fully in:

	include/uapi/linux/scmi.h

   As described succinctly in the above UAPI header too, this API is meant
   to be called on a few special files named 'control' that are populated
   into the tree:

   .
   |-- all_des_enable
   .....
   |-- components
   |   |-- cpu
   |   |-- ...
   |   |-- periph
   |   `-- unspec
   |-- control                   <<<<<<<<<<<<<<
   .....................

   |-- groups
   |   |-- 0
   |   |   |-- available_update_intervals_ms
   |   |   |-- composing_des
   |   |   |-- control           <<<<<<<<<<<<<<
   .....................
   |   |-- 1
   |   |   |-- available_update_intervals_ms
   |   |   |-- composing_des
   |   |   |-- control           <<<<<<<<<<<<<<
   .....................
   |   `-- 2
   |       |-- available_update_intervals_ms
   |       |-- composing_des
   |       |-- control           <<<<<<<<<<<<<<
   .....................

  This will allow a tool to:

   - use some IOCTLs to configure a set of properties equivalent to the
     ones above in FS
   - use some other IOCTLs for direct access to data in binary format
     for a single DEs or all of them

 4. [FUTURE/NOT IN THIS V2]
    Another alternative and completely binary direct raw access interface
    accessible via a new set of memory .mmap'able special files so as to
    allow userspace tools to access SCMI Telemetry data directly in binary
    form without any kernel mediation.


NOTE THAT this series, though, at the firmware interface level still
supports ONLY the previous SCMI Telemetry ALPHA_0 [1] specification NOT the
new recently released BETA [0].


Missing feats & next steps
--------------------------
 - support SCMI v4.0 BETA
 - add direct access interface via mmap-able 'raw' files
 - add streaming mode interface via 'pipe' file (tentative)
 - evolve/enhance app in tools/testing/scmi/stlm to be interactive
 

KNOWN ISSUES
------------
 - STLMFS code layout and location...nothing lives in fs/ and no FS Kconfig
 - lazy filesystem population implementation is dubious (albeit simpler:D)
 - Documentation is still incomplete
 - residual sparse/smatch static analyzers errors
 - stlm tool utility is minimal for testing or development

Based on V6.19-rc3, tested on an emulated setup.

Any feedback welcome,

Thanks,
Cristian

----

V1 --> V2
---
 - rebased on v6.19-rc3
 - harden TDCF shared memory areas accesses by using proper accessors
 - reworked protocol resources lifecycle to allow lazy enumeration
 - using NEW FS mount API
 - reworked FS inode allocation to use a std kmem_cache
 - fixed a few IOCTLs support routine to support lazy enumeration
 - added (RFC) a new FS lazy mount option to support lazily population of
   some subtrees of the FS (des/ groups/ components/)
 - reworked implementation of components/ alternative FS view to use
   symlinks instead of hardlinks
 - added a basic simple (RFC) testing tool to exercise UAPI ioctls interface
 - hardened Telmetry protocol and driver to support partial out-of-spec FW
   lacking some cmds (best effort)
 - reworked probing races handling
 - reviewed behaviour on unmount/unload
 - added support for Boot_ON Telemetry by supporting SCMI Telemetry cmds:
   + DE_ENABLED_LIST
   + CONFIG_GET
 - added FS and ABI docs

RFC --> V1
---
 - moved from SysFS/chardev to a full fledged FS
 - added support for SCMI Telemetry BLK timestamps


Thanks,
Cristian

[0]: https://developer.arm.com/documentation/den0056/fb/?lang=en
[1]: https://developer.arm.com/documentation/den0056/f/?lang=en
[2]: https://lore.kernel.org/arm-scmi/20250620192813.2463367-1-cristian.marussi@arm.com/


Cristian Marussi (17):
  firmware: arm_scmi: Define a common SCMI_MAX_PROTOCOLS value
  firmware: arm_scmi: Reduce the scope of protocols mutex
  firmware: arm_scmi: Allow protocols to register for notifications
  uapi: Add ARM SCMI definitions
  firmware: arm_scmi: Add Telemetry protocol support
  include: trace: Add Telemetry trace events
  firmware: arm_scmi: Use new Telemetry traces
  firmware: arm_scmi: Add System Telemetry driver
  fs/stlmfs: Document ARM SCMI Telemetry filesystem
  firmware: arm_scmi: Add System Telemetry ioctls support
  fs/stlmfs: Document alternative ioctl based binary interface
  firmware: arm_scmi: Add Telemetry components view
  fs/stlmfs: Document alternative topological view
  [RFC] docs: stlmfs: Document ARM SCMI Telemetry FS ABI
  [RFC] firmware: arm_scmi: Add lazy population support to Telemetry FS
  fs/stlmfs: Document lazy mode and related mount option
  [RFC] tools/scmi: Add SCMI Telemetry testing tool

 Documentation/ABI/testing/stlmfs              |  153 +
 Documentation/filesystems/stlmfs.rst          |  311 ++
 MAINTAINERS                                   |    1 +
 drivers/firmware/arm_scmi/Kconfig             |   10 +
 drivers/firmware/arm_scmi/Makefile            |    3 +-
 drivers/firmware/arm_scmi/common.h            |    4 +
 drivers/firmware/arm_scmi/driver.c            |   64 +-
 drivers/firmware/arm_scmi/notify.c            |   32 +-
 drivers/firmware/arm_scmi/notify.h            |    8 +-
 drivers/firmware/arm_scmi/protocols.h         |    7 +
 .../firmware/arm_scmi/scmi_system_telemetry.c | 2927 +++++++++++++++++
 drivers/firmware/arm_scmi/telemetry.c         | 2710 +++++++++++++++
 include/linux/scmi_protocol.h                 |  191 +-
 include/trace/events/scmi.h                   |   48 +-
 include/uapi/linux/scmi.h                     |  287 ++
 tools/testing/scmi/Makefile                   |   25 +
 tools/testing/scmi/stlm.c                     |  385 +++
 17 files changed, 7125 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/ABI/testing/stlmfs
 create mode 100644 Documentation/filesystems/stlmfs.rst
 create mode 100644 drivers/firmware/arm_scmi/scmi_system_telemetry.c
 create mode 100644 drivers/firmware/arm_scmi/telemetry.c
 create mode 100644 include/uapi/linux/scmi.h
 create mode 100644 tools/testing/scmi/Makefile
 create mode 100644 tools/testing/scmi/stlm.c

-- 
2.52.0


