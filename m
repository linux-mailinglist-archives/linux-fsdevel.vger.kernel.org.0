Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1082B467A3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 16:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381746AbhLCPcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 10:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245140AbhLCPcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:32:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38774C061751;
        Fri,  3 Dec 2021 07:29:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FB54B8268D;
        Fri,  3 Dec 2021 15:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A97AC53FCD;
        Fri,  3 Dec 2021 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638545344;
        bh=mLFTikH/Z3Nv66wcPcXKQPL0BhIIZQ0bnyHXZXlZSmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LHToFSp5YeS+mMVUSZnE4QQlDCLSV3lxBtpCSnKzP5vadhtizusmPmjFhbCtTT6ce
         u71wFWp7s6OEylcYA8vGgeOwNnNiUT6irDLveFG9hDuC6ut+dLkHzxgJkBkjuk+QE8
         87evnCAcHe40GYHuagecEZErjkanD8/vPUHEspdY=
Date:   Fri, 3 Dec 2021 16:29:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, akpm@linux-foundation.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/6] selftests: add tests_sysfs module
Message-ID: <Yao3vtSKBKLyQY1E@kroah.com>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029184500.2821444-4-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 11:44:57AM -0700, Luis Chamberlain wrote:
> This adds a new selftest module which can be used to test sysfs, which
> would otherwise require using an existing driver. This lets us muck
> with a template driver to test breaking things without affecting
> system behaviour or requiring the dependencies of a real device
> driver.

Test sysfs "how"?  What exactly are you wanting to test?

I see lots of things in this code as examples of how to NOT use sysfs,
so are you testing my review cycles?  :)

> A series of 28 tests are added. Support for using two device types are
> supported:
> 
>   * misc
>   * block

So you are testing the misc and block sysfs apis from within the kernel?

> Contrary to sysctls, sysfs requires a full write to happen at once, and
> so we reduce the digit tests to single writes. Two main sysfs knobs are
> provided for testing reading/storing, one which doesn't incur any
> delays and another which can incur programmed delays. What locks are
> held, if any, are configurable, at module load time, or through dynamic
> configuration at run time.

I do not understand this paragraph at all.  What are you trying to say?

sysfs is a read/write api, yes.  That's all, nothing fancy.  What does
delays have to do with anything?

> Since sysfs is a technically filesystem, but a pseudo one, which
> requires a kernel user, our test_sysfs module and respective test script
> embraces fstests format for tests in the kernel ring bufffer. Likewise,
> a scraper for kernel crashes is provided which matches what fstests does
> as well.

What is crashing?

> Two tests are kept disabled as they are a demonstration of what not to
> do as it can cause a deadlock with sysfs. These tests provides a mechanism
> to easily show proof and demo how the deadlock can happen:

Yes you can do foolish things in sysfs, but why are you limiting
yourself to just 2 ways to shoot yourself in the foot?

Again, I do not understand the goal here at all.  What is this file for?

> Demos the deadlock with a device specific lock
> ./tools/testing/selftests/sysfs/sysfs.sh -t 0027
> 
> Demos the deadlock with rtnl_lock()
> ./tools/testing/selftests/sysfs/sysfs.sh -t 0028
> 
> Drivers should *avoid* sharing a lock on rmmod and on sysfs ops.
> 
> This selftests will shortly be expanded upon with more tests which
> require further kernel changes in order to provide better test
> coverage.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  MAINTAINERS                            |    7 +
>  lib/Kconfig.debug                      |   12 +
>  lib/Makefile                           |    1 +
>  lib/test_sysfs.c                       |  894 ++++++++++++++++++
>  tools/testing/selftests/sysfs/Makefile |   12 +
>  tools/testing/selftests/sysfs/config   |    2 +
>  tools/testing/selftests/sysfs/settings |    1 +
>  tools/testing/selftests/sysfs/sysfs.sh | 1197 ++++++++++++++++++++++++
>  8 files changed, 2126 insertions(+)
>  create mode 100644 lib/test_sysfs.c
>  create mode 100644 tools/testing/selftests/sysfs/Makefile
>  create mode 100644 tools/testing/selftests/sysfs/config
>  create mode 100644 tools/testing/selftests/sysfs/settings
>  create mode 100755 tools/testing/selftests/sysfs/sysfs.sh
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f87f622ac18..8b458c4dd577 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18393,6 +18393,13 @@ L:	linux-mmc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/mmc/host/sdhci-pci-dwc-mshc.c
>  
> +SYSFS TEST DRIVER
> +M:	Luis Chamberlain <mcgrof@kernel.org>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	lib/test_sysfs.c
> +F:	tools/testing/selftests/sysfs/
> +
>  SYSTEM CONFIGURATION (SYSCON)
>  M:	Lee Jones <lee.jones@linaro.org>
>  M:	Arnd Bergmann <arnd@arndb.de>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 44a6df361016..ec531b423c0e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2344,6 +2344,18 @@ config TEST_SYSCTL
>  
>  	  If unsure, say N.
>  
> +config TEST_SYSFS
> +	tristate "sysfs test driver"
> +	depends on SYSFS
> +	depends on NET
> +	depends on BLOCK
> +	help
> +	  This builds the "test_sysfs" module. This driver enables to test the
> +	  sysfs file system safely without affecting production knobs which
> +	  might alter system functionality.
> +
> +	  If unsure, say N.
> +
>  config BITFIELD_KUNIT
>  	tristate "KUnit test bitfield functions at runtime"
>  	depends on KUNIT
> diff --git a/lib/Makefile b/lib/Makefile
> index 364c23f15578..741c1be29781 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
>  obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
>  CFLAGS_test_bitops.o += -Werror
>  obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
> +obj-$(CONFIG_TEST_SYSFS) += test_sysfs.o
>  obj-$(CONFIG_TEST_HASH) += test_hash.o test_siphash.o
>  obj-$(CONFIG_TEST_IDA) += test_ida.o
>  obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
> diff --git a/lib/test_sysfs.c b/lib/test_sysfs.c
> new file mode 100644
> index 000000000000..2a6ec072da60
> --- /dev/null
> +++ b/lib/test_sysfs.c
> @@ -0,0 +1,894 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1

Again, sorry, but no, I am going to object to this license as you are
only accessing a GPL-v2-only api.  Any other license on a file that
interacts with that, especially for core stuff like testing the
functionality of this code, needs to have that same license.  Sorry.

> +/*
> + * Copyright (C) 2021 Luis Chamberlain <mcgrof@kernel.org>
> + *
> + * sysfs test driver
> + *
> + * This module allows us to add race conditions which we can test for
> + * against the sysfs filesystem.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/async.h>
> +#include <linux/delay.h>
> +#include <linux/vmalloc.h>
> +#include <linux/debugfs.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/genhd.h>
> +#include <linux/blkdev.h>
> +
> +static bool enable_lock;
> +module_param(enable_lock, bool_enable_only, 0644);
> +MODULE_PARM_DESC(enable_lock,
> +		 "enable locking on reads / stores from the start");

This isn't the 1990's why have module parameters when you are dealing
with sysfs?  :)


> +
> +static bool enable_lock_on_rmmod;
> +module_param(enable_lock_on_rmmod, bool_enable_only, 0644);
> +MODULE_PARM_DESC(enable_lock_on_rmmod,
> +		 "enable locking on rmmod");
> +
> +static bool use_rtnl_lock;
> +module_param(use_rtnl_lock, bool_enable_only, 0644);
> +MODULE_PARM_DESC(use_rtnl_lock,
> +		 "use an rtnl_lock instead of the device mutex_lock");
> +
> +static unsigned int write_delay_msec_y = 500;
> +module_param_named(write_delay_msec_y, write_delay_msec_y, uint, 0644);
> +MODULE_PARM_DESC(write_delay_msec_y, "msec write delay for writes to y");
> +
> +static unsigned int test_devtype;
> +module_param_named(devtype, test_devtype, uint, 0644);
> +MODULE_PARM_DESC(devtype, "device type to register");
> +
> +static bool enable_busy_alloc;
> +module_param(enable_busy_alloc, bool_enable_only, 0644);
> +MODULE_PARM_DESC(enable_busy_alloc, "do a fake allocation during writes");
> +
> +static bool enable_debugfs;
> +module_param(enable_debugfs, bool_enable_only, 0644);
> +MODULE_PARM_DESC(enable_debugfs, "enable a few debugfs files");
> +
> +static bool enable_verbose_writes;
> +module_param(enable_verbose_writes, bool_enable_only, 0644);
> +MODULE_PARM_DESC(enable_debugfs, "enable stores to print verbose information");
> +
> +static unsigned int delay_rmmod_ms;
> +module_param_named(delay_rmmod_ms, delay_rmmod_ms, uint, 0644);
> +MODULE_PARM_DESC(delay_rmmod_ms, "if set how many ms to delay rmmod before device deletion");
> +
> +static bool enable_verbose_rmmod;
> +module_param(enable_verbose_rmmod, bool_enable_only, 0644);
> +MODULE_PARM_DESC(enable_verbose_rmmod, "enable verbose print messages on rmmod");
> +
> +static int sysfs_test_major;
> +
> +/**
> + * test_config - used for configuring how the sysfs test device will behave
> + *
> + * @enable_lock: if enabled a lock will be used when reading/storing variables
> + * @enable_lock_on_rmmod: if enabled a lock will be used when reading/storing
> + *	sysfs attributes, but it will also be used to lock on rmmod. This is
> + *	useful to test for a deadlock and should serve as an example of what
> + *	drivers should *not* do.
> + * @use_rtnl_lock: if enabled instead of configuration specific mutex, we'll
> + *	use the rtnl_lock. If your test case is modifying this on the fly
> + *	while doing other stores / reads, things will break as a lock can be
> + *	left contending. Best is that tests use this knob serially, without
> + *	allowing userspace to modify other knobs while this one changes.

Why are any of these locks needed at all?  What are you trying to test?
How badly this code abuses locks and sysfs?

I do not understand how locking models matter to how the sysfs api works
at all.

Again, what exactly are you trying to test?  What portions of the sysfs
api?  I see misc and block device interactions here, those have
different apis and have nothing to do with sysfs other than they too
have sysfs interactions.

If you want to test the sysfs api, that's great, but that is not what
you are doing here, it's a mis/match of block/misc bad things.

> + * @write_delay_msec_y: the amount of delay to use when writing to y
> + * @enable_busy_alloc: if enabled we'll do a large allocation between
> + *	writes. We immediately free right away. We also schedule to give the
> + *	kernel some time to re-use any memory we don't need. This is intened
> + *	to mimic typical driver behaviour.
> + */
> +struct test_config {
> +	bool enable_lock;
> +	bool enable_lock_on_rmmod;
> +	bool use_rtnl_lock;
> +	unsigned int write_delay_msec_y;
> +	bool enable_busy_alloc;
> +};
> +
> +/**
> + * enum sysfs_test_devtype - sysfs device type
> + * @TESTDEV_TYPE_MISC: misc device type
> + * @TESTDEV_TYPE_BLOCK: use a block device for the sysfs test device.
> + */
> +enum sysfs_test_devtype {
> +	TESTDEV_TYPE_MISC = 0,
> +	TESTDEV_TYPE_BLOCK,
> +};
> +
> +/**
> + * sysfs_test_device - test device to help test sysfs
> + *
> + * @devtype: the type of device to use
> + * @config: configuration for the test
> + * @config_mutex: protects configuration of test
> + * @misc_dev: we use a misc device under the hood
> + * @disk: represents a disk when used as a block device
> + * @dev: pointer to misc_dev's own struct device
> + * @dev_idx: unique ID for test device
> + * @x: variable we can use to test read / store
> + * @y: slow variable we can use to test read / store
> + */
> +struct sysfs_test_device {
> +	enum sysfs_test_devtype devtype;
> +	struct test_config config;
> +	struct mutex config_mutex;
> +	struct miscdevice misc_dev;
> +	struct gendisk *disk;
> +	struct device *dev;

So you have one device that controls the lifecycle (misc_dev) and then
pointers to 2 others with different lifecycles?  That's odd.

And dev is not needed at all, please drop.


> +	int dev_idx;
> +	int x;
> +	int y;
> +};
> +
> +static struct sysfs_test_device *first_test_dev;
> +
> +static struct miscdevice *dev_to_misc_dev(struct device *dev)
> +{
> +	return dev_get_drvdata(dev);
> +}
> +
> +static struct sysfs_test_device *misc_dev_to_test_dev(struct miscdevice *misc_dev)
> +{
> +	return container_of(misc_dev, struct sysfs_test_device, misc_dev);
> +}
> +
> +static struct sysfs_test_device *devblock_to_test_dev(struct device *dev)
> +{
> +	return (struct sysfs_test_device *)dev_to_disk(dev)->private_data;
> +}
> +
> +static struct sysfs_test_device *devmisc_to_testdev(struct device *dev)
> +{
> +	struct miscdevice *misc_dev;
> +
> +	misc_dev = dev_to_misc_dev(dev);
> +	return misc_dev_to_test_dev(misc_dev);
> +}
> +
> +static struct sysfs_test_device *dev_to_test_dev(struct device *dev)
> +{
> +	if (test_devtype == TESTDEV_TYPE_MISC)
> +		return devmisc_to_testdev(dev);
> +	else if (test_devtype == TESTDEV_TYPE_BLOCK)
> +		return devblock_to_test_dev(dev);
> +	return NULL;
> +}
> +
> +static void test_dev_config_lock(struct sysfs_test_device *test_dev)
> +{
> +	struct test_config *config = &test_dev->config;
> +
> +	if (config->enable_lock) {
> +		if (config->use_rtnl_lock)
> +			rtnl_lock();
> +		else
> +			mutex_lock(&test_dev->config_mutex);
> +	}
> +}
> +
> +static void test_dev_config_unlock(struct sysfs_test_device *test_dev)
> +{
> +	struct test_config *config = &test_dev->config;
> +
> +	if (config->enable_lock) {
> +		if (config->use_rtnl_lock)
> +			rtnl_unlock();
> +		else
> +			mutex_unlock(&test_dev->config_mutex);
> +	}
> +}
> +
> +static void test_dev_config_lock_rmmod(struct sysfs_test_device *test_dev)
> +{
> +	struct test_config *config = &test_dev->config;
> +
> +	if (config->enable_lock_on_rmmod)
> +		test_dev_config_lock(test_dev);
> +}
> +
> +static void test_dev_config_unlock_rmmod(struct sysfs_test_device *test_dev)
> +{
> +	struct test_config *config = &test_dev->config;
> +
> +	if (config->enable_lock_on_rmmod)
> +		test_dev_config_unlock(test_dev);
> +}
> +
> +static void free_test_dev_sysfs(struct sysfs_test_device *test_dev)
> +{
> +	if (test_dev) {
> +		kfree_const(test_dev->misc_dev.name);
> +		test_dev->misc_dev.name = NULL;
> +		kfree(test_dev);
> +		test_dev = NULL;
> +	}
> +}
> +
> +static void test_sysfs_reset_vals(struct sysfs_test_device *test_dev)
> +{
> +	test_dev->x = 3;
> +	test_dev->y = 4;
> +}
> +
> +static ssize_t config_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config = &test_dev->config;
> +	int len = 0;
> +
> +	test_dev_config_lock(test_dev);
> +
> +	len += sysfs_emit_at(buf, len, "Configuration for: %s\n",
> +			     dev_name(dev));
> +	len += sysfs_emit_at(buf, len, "x:\t%d\n", test_dev->x);
> +	len += sysfs_emit_at(buf, len, "y:\t%d\n", test_dev->y);
> +	len += sysfs_emit_at(buf, len, "enable_lock:\t%s\n",
> +			     config->enable_lock ? "true" : "false");
> +	len += sysfs_emit_at(buf, len, "enable_lock_on_rmmmod:\t%s\n",
> +			     config->enable_lock_on_rmmod ? "true" : "false");
> +	len += sysfs_emit_at(buf, len, "use_rtnl_lock:\t%s\n",
> +			     config->use_rtnl_lock ? "true" : "false");
> +	len += sysfs_emit_at(buf, len, "write_delay_msec_y:\t%d\n",
> +			     config->write_delay_msec_y);
> +	len += sysfs_emit_at(buf, len, "enable_busy_alloc:\t%s\n",
> +			     config->enable_busy_alloc ? "true" : "false");
> +	len += sysfs_emit_at(buf, len, "enable_debugfs:\t%s\n",
> +			     enable_debugfs ? "true" : "false");
> +	len += sysfs_emit_at(buf, len, "enable_verbose_writes:\t%s\n",
> +			     enable_verbose_writes ? "true" : "false");

sysfs is one-value-per-file.  This is a huge violation of it and is not
allowed at all.  This function alone would cause me to reject it :(

Also, you are creating sysfs files, where are the Documentation/ABI/
entries?


> +
> +	test_dev_config_unlock(test_dev);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RO(config);
> +
> +static ssize_t reset_store(struct device *dev,
> +			   struct device_attribute *attr,
> +			   const char *buf, size_t count)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config = &test_dev->config;
> +
> +	/*
> +	 * We compromise and simplify this condition and do not use a lock
> +	 * here as the lock type can change.
> +	 */
> +	config->enable_lock = false;
> +	config->enable_lock_on_rmmod = false;
> +	config->use_rtnl_lock = false;
> +	config->enable_busy_alloc = false;
> +	test_sysfs_reset_vals(test_dev);

I do not understand how a lock matters here.

And you can accept any data at all?  That's not a valid test :(

> +
> +	dev_info(dev, "reset\n");
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(reset);
> +
> +static void test_dev_busy_alloc(struct sysfs_test_device *test_dev)
> +{
> +	struct test_config *config = &test_dev->config;
> +	char *ignore;
> +
> +	if (!config->enable_busy_alloc)
> +		return;
> +
> +	ignore = kzalloc(sizeof(struct sysfs_test_device) * 10, GFP_KERNEL);
> +	kfree(ignore);
> +
> +	schedule();
> +}
> +
> +static ssize_t test_dev_x_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	int ret;
> +
> +	test_dev_busy_alloc(test_dev);
> +	test_dev_config_lock(test_dev);
> +
> +	ret = kstrtoint(buf, 10, &test_dev->x);
> +	if (ret)
> +		count = ret;
> +
> +	if (enable_verbose_writes)
> +		dev_info(test_dev->dev, "wrote x = %d\n", test_dev->x);
> +
> +	test_dev_config_unlock(test_dev);
> +
> +	return count;
> +}
> +
> +static ssize_t test_dev_x_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	int ret;
> +
> +	test_dev_config_lock(test_dev);
> +	ret = sysfs_emit(buf, "%d\n", test_dev->x);
> +	test_dev_config_unlock(test_dev);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RW(test_dev_x);
> +
> +static ssize_t test_dev_y_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config;
> +	int y;
> +	int ret;
> +
> +	test_dev_busy_alloc(test_dev);
> +	test_dev_config_lock(test_dev);
> +
> +	config = &test_dev->config;
> +
> +	ret = kstrtoint(buf, 10, &y);
> +	if (ret)
> +		count = ret;
> +
> +	msleep(config->write_delay_msec_y);
> +	test_dev->y = test_dev->x + y + 7;

What is "7" for?


> +
> +	if (enable_verbose_writes)
> +		dev_info(test_dev->dev, "wrote y = %d\n", test_dev->y);
> +
> +	test_dev_config_unlock(test_dev);
> +
> +	return count;
> +}
> +
> +static ssize_t test_dev_y_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	int ret;
> +
> +	test_dev_config_lock(test_dev);
> +	ret = sysfs_emit(buf, "%d\n", test_dev->y);
> +	test_dev_config_unlock(test_dev);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RW(test_dev_y);
> +
> +static ssize_t config_enable_lock_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config = &test_dev->config;
> +	int ret;
> +	int val;
> +
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * We compromise for simplicty and do not lock when changing
> +	 * locking configuration, with the assumption userspace tests
> +	 * will know this.
> +	 */
> +	if (val)
> +		config->enable_lock = true;
> +	else
> +		config->enable_lock = false;
> +
> +	return count;
> +}
> +
> +static ssize_t config_enable_lock_show(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config = &test_dev->config;
> +	ssize_t ret;
> +
> +	test_dev_config_lock(test_dev);
> +	ret = sysfs_emit(buf, "%d\n", config->enable_lock);
> +	test_dev_config_unlock(test_dev);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RW(config_enable_lock);
> +
> +static ssize_t config_enable_lock_on_rmmod_store(struct device *dev,
> +						 struct device_attribute *attr,
> +						 const char *buf, size_t count)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config = &test_dev->config;
> +	int ret;
> +	int val;
> +
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	test_dev_config_lock(test_dev);
> +	if (val)
> +		config->enable_lock_on_rmmod = true;
> +	else
> +		config->enable_lock_on_rmmod = false;
> +	test_dev_config_unlock(test_dev);
> +
> +	return count;
> +}
> +
> +static ssize_t config_enable_lock_on_rmmod_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config = &test_dev->config;
> +	ssize_t ret;
> +
> +	test_dev_config_lock(test_dev);
> +	ret = sysfs_emit(buf, "%d\n", config->enable_lock_on_rmmod);
> +	test_dev_config_unlock(test_dev);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RW(config_enable_lock_on_rmmod);
> +
> +static ssize_t config_use_rtnl_lock_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config = &test_dev->config;
> +	int ret;
> +	int val;
> +
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * We compromise and simplify this condition and do not use a lock
> +	 * here as the lock type can change.
> +	 */
> +	if (val)
> +		config->use_rtnl_lock = true;
> +	else
> +		config->use_rtnl_lock = false;
> +
> +	return count;
> +}
> +
> +static ssize_t config_use_rtnl_lock_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config = &test_dev->config;
> +
> +	return sysfs_emit(buf, "%d\n", config->use_rtnl_lock);
> +}
> +static DEVICE_ATTR_RW(config_use_rtnl_lock);
> +
> +static ssize_t config_write_delay_msec_y_store(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t count)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config = &test_dev->config;
> +	int ret;
> +	int val;
> +
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	test_dev_config_lock(test_dev);
> +	config->write_delay_msec_y = val;
> +	test_dev_config_unlock(test_dev);
> +
> +	return count;
> +}
> +
> +static ssize_t config_write_delay_msec_y_show(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config = &test_dev->config;
> +
> +	return sysfs_emit(buf, "%d\n", config->write_delay_msec_y);
> +}
> +static DEVICE_ATTR_RW(config_write_delay_msec_y);
> +
> +static ssize_t config_enable_busy_alloc_store(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t count)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config = &test_dev->config;
> +	int ret;
> +	int val;
> +
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	test_dev_config_lock(test_dev);
> +	config->enable_busy_alloc = val;
> +	test_dev_config_unlock(test_dev);
> +
> +	return count;
> +}
> +
> +static ssize_t config_enable_busy_alloc_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> +	struct test_config *config = &test_dev->config;
> +
> +	return sysfs_emit(buf, "%d\n", config->enable_busy_alloc);
> +}
> +static DEVICE_ATTR_RW(config_enable_busy_alloc);
> +
> +#define TEST_SYSFS_DEV_ATTR(name)		(&dev_attr_##name.attr)

Just spell it out please, no need for a macro.

> +
> +static struct attribute *test_dev_attrs[] = {
> +	/* Generic driver knobs go here */
> +	TEST_SYSFS_DEV_ATTR(config),
> +	TEST_SYSFS_DEV_ATTR(reset),
> +
> +	/* These are used to test sysfs */
> +	TEST_SYSFS_DEV_ATTR(test_dev_x),
> +	TEST_SYSFS_DEV_ATTR(test_dev_y),
> +
> +	/*
> +	 * These are configuration knobs to modify how we test sysfs when
> +	 * doing reads / stores.
> +	 */
> +	TEST_SYSFS_DEV_ATTR(config_enable_lock),
> +	TEST_SYSFS_DEV_ATTR(config_enable_lock_on_rmmod),
> +	TEST_SYSFS_DEV_ATTR(config_use_rtnl_lock),
> +	TEST_SYSFS_DEV_ATTR(config_write_delay_msec_y),
> +	TEST_SYSFS_DEV_ATTR(config_enable_busy_alloc),
> +
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(test_dev);

That's a weak "test" of how attribute groups work and how they can work.
It's pretty much the simplest way.  why?

> +static int sysfs_test_dev_alloc_miscdev(struct sysfs_test_device *test_dev)
> +{
> +	struct miscdevice *misc_dev;
> +
> +	misc_dev = &test_dev->misc_dev;
> +	misc_dev->minor = MISC_DYNAMIC_MINOR;
> +	misc_dev->name = kasprintf(GFP_KERNEL, "test_sysfs%d", test_dev->dev_idx);
> +	if (!misc_dev->name) {
> +		pr_err("Cannot alloc misc_dev->name\n");
> +		return -ENOMEM;
> +	}
> +	misc_dev->groups = test_dev_groups;
> +
> +	return 0;
> +}
> +
> +static int testdev_open(struct block_device *bdev, fmode_t mode)
> +{
> +	return -EINVAL;

Why?

> +}
> +
> +static void testdev_submit_bio(struct bio *bio)
> +{
> +}

Huh?

> +
> +static void testdev_slot_free_notify(struct block_device *bdev,
> +				     unsigned long index)
> +{
> +}

Why nothing?

> +
> +static int testdev_rw_page(struct block_device *bdev, sector_t sector,
> +			   struct page *page, unsigned int op)
> +{
> +	return -EOPNOTSUPP;
> +}

What is this doing?

> +
> +static const struct block_device_operations sysfs_testdev_ops = {
> +	.open = testdev_open,
> +	.submit_bio = testdev_submit_bio,
> +	.swap_slot_free_notify = testdev_slot_free_notify,
> +	.rw_page = testdev_rw_page,
> +	.owner = THIS_MODULE
> +};
> +
> +static int sysfs_test_dev_alloc_blockdev(struct sysfs_test_device *test_dev)
> +{
> +	int ret = -ENOMEM;
> +
> +	test_dev->disk = blk_alloc_disk(NUMA_NO_NODE);
> +	if (!test_dev->disk) {
> +		pr_err("Error allocating disk structure for device %d\n",
> +		       test_dev->dev_idx);
> +		goto out;
> +	}
> +
> +	test_dev->disk->major = sysfs_test_major;
> +	test_dev->disk->first_minor = test_dev->dev_idx + 1;
> +	test_dev->disk->fops = &sysfs_testdev_ops;
> +	test_dev->disk->private_data = test_dev;
> +	snprintf(test_dev->disk->disk_name, sizeof(test_dev->disk->disk_name),
> +		 "test_sysfs%d", test_dev->dev_idx);
> +	set_capacity(test_dev->disk, 0);
> +	blk_queue_flag_set(QUEUE_FLAG_NONROT, test_dev->disk->queue);
> +	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, test_dev->disk->queue);
> +	blk_queue_physical_block_size(test_dev->disk->queue, PAGE_SIZE);
> +	blk_queue_max_discard_sectors(test_dev->disk->queue, UINT_MAX);
> +	blk_queue_flag_set(QUEUE_FLAG_DISCARD, test_dev->disk->queue);
> +
> +	return 0;
> +out:
> +	return ret;
> +}

What does this block device do?

> +
> +static struct sysfs_test_device *alloc_test_dev_sysfs(int idx)
> +{
> +	struct sysfs_test_device *test_dev;
> +	int ret;
> +
> +	switch (test_devtype) {
> +	case TESTDEV_TYPE_MISC:
> +	       fallthrough;
> +	case TESTDEV_TYPE_BLOCK:
> +		break;

That's the only 2 types you have, why test?

> +	default:
> +		return NULL;
> +	}
> +
> +	test_dev = kzalloc(sizeof(struct sysfs_test_device), GFP_KERNEL);
> +	if (!test_dev)
> +		goto err_out;
> +
> +	mutex_init(&test_dev->config_mutex);
> +	test_dev->dev_idx = idx;
> +	test_dev->devtype = test_devtype;
> +
> +	if (test_dev->devtype == TESTDEV_TYPE_MISC) {
> +		ret = sysfs_test_dev_alloc_miscdev(test_dev);
> +		if (ret)
> +			goto err_out_free;
> +	} else if (test_dev->devtype == TESTDEV_TYPE_BLOCK) {
> +		ret = sysfs_test_dev_alloc_blockdev(test_dev);
> +		if (ret)
> +			goto err_out_free;
> +	}
> +	return test_dev;
> +
> +err_out_free:
> +	kfree(test_dev);
> +	test_dev = NULL;
> +err_out:
> +	return NULL;
> +}
> +
> +static int register_test_dev_sysfs_misc(struct sysfs_test_device *test_dev)
> +{
> +	int ret;
> +
> +	ret = misc_register(&test_dev->misc_dev);
> +	if (ret)
> +		return ret;
> +
> +	test_dev->dev = test_dev->misc_dev.this_device;

Why are you messing with the internals of a misc device's struct device?
That's not for anyone to play with.

> +
> +	return 0;
> +}
> +
> +static int register_test_dev_sysfs_block(struct sysfs_test_device *test_dev)
> +{
> +	int ret;
> +
> +	ret = device_add_disk(NULL, test_dev->disk, test_dev_groups);
> +	if (ret) {
> +		blk_cleanup_disk(test_dev->disk);
> +		return ret;
> +	}
> +
> +	test_dev->dev = disk_to_dev(test_dev->disk);
> +
> +	return 0;
> +}
> +
> +static struct sysfs_test_device *register_test_dev_sysfs(void)
> +{
> +	struct sysfs_test_device *test_dev = NULL;
> +	int ret;
> +
> +	test_dev = alloc_test_dev_sysfs(0);
> +	if (!test_dev)
> +		goto out;
> +
> +	if (test_dev->devtype == TESTDEV_TYPE_MISC) {
> +		ret = register_test_dev_sysfs_misc(test_dev);
> +		if (ret) {
> +			pr_err("could not register misc device: %d\n", ret);
> +			goto out_free_dev;
> +		}
> +	} else if (test_dev->devtype == TESTDEV_TYPE_BLOCK) {
> +		ret = register_test_dev_sysfs_block(test_dev);
> +		if (ret) {
> +			pr_err("could not register block device: %d\n", ret);
> +			goto out_free_dev;
> +		}
> +	}
> +
> +	dev_info(test_dev->dev, "interface ready\n");
> +
> +out:
> +	return test_dev;
> +out_free_dev:
> +	free_test_dev_sysfs(test_dev);
> +	return NULL;
> +}
> +
> +static struct sysfs_test_device *register_test_dev_set_config(void)
> +{
> +	struct sysfs_test_device *test_dev;
> +	struct test_config *config;
> +
> +	test_dev = register_test_dev_sysfs();
> +	if (!test_dev)
> +		return NULL;
> +
> +	config = &test_dev->config;
> +
> +	if (enable_lock)
> +		config->enable_lock = true;
> +	if (enable_lock_on_rmmod)
> +		config->enable_lock_on_rmmod = true;
> +	if (use_rtnl_lock)
> +		config->use_rtnl_lock = true;
> +	if (enable_busy_alloc)
> +		config->enable_busy_alloc = true;
> +
> +	config->write_delay_msec_y = write_delay_msec_y;
> +	test_sysfs_reset_vals(test_dev);
> +
> +	return test_dev;
> +}
> +
> +static void unregister_test_dev_sysfs_misc(struct sysfs_test_device *test_dev)
> +{
> +	misc_deregister(&test_dev->misc_dev);
> +}
> +
> +static void unregister_test_dev_sysfs_block(struct sysfs_test_device *test_dev)
> +{
> +	del_gendisk(test_dev->disk);
> +	blk_cleanup_disk(test_dev->disk);
> +}
> +
> +static void unregister_test_dev_sysfs(struct sysfs_test_device *test_dev)
> +{
> +	test_dev_config_lock_rmmod(test_dev);
> +
> +	dev_info(test_dev->dev, "removing interface\n");
> +
> +	if (test_dev->devtype == TESTDEV_TYPE_MISC)
> +		unregister_test_dev_sysfs_misc(test_dev);
> +	else if (test_dev->devtype == TESTDEV_TYPE_BLOCK)
> +		unregister_test_dev_sysfs_block(test_dev);
> +
> +	test_dev_config_unlock_rmmod(test_dev);
> +
> +	free_test_dev_sysfs(test_dev);
> +}
> +
> +static struct dentry *debugfs_dir;

Why get debugfs involved?


> +
> +/* When read represents how many times we have reset the first_test_dev */
> +static u8 reset_first_test_dev;
> +
> +static ssize_t read_reset_first_test_dev(struct file *file,
> +					 char __user *user_buf,
> +					 size_t count, loff_t *ppos)
> +{
> +	ssize_t len;
> +	char buf[32];
> +
> +	reset_first_test_dev++;
> +	len = sprintf(buf, "%d\n", reset_first_test_dev);
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +}
> +
> +static ssize_t write_reset_first_test_dev(struct file *file,
> +					  const char __user *user_buf,
> +					  size_t count, loff_t *ppos)
> +{
> +	if (!try_module_get(THIS_MODULE))

Totally racy, broken, and not allowed, sorry.

