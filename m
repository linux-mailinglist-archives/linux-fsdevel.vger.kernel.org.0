Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6736546E067
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 02:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhLIBwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 20:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhLIBwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:52:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF19FC061746;
        Wed,  8 Dec 2021 17:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PFXxEsCD002H6z6kUcrx6q0rbcFFFAOVpGxJAWJ1268=; b=CJf7KqGOSPi2XgwMuvwekpdj1W
        X7W0e98ZCsVtZ9l0EX8jrNpwLE6qElS5nNu8O2iVS2Q5bG/8MlODAdL2uhNIKglNa61QrsOpzqWB7
        yA+LP+nZ8SmkmqNUGS8mqIBnN8Ypr4mWFu7DyXldhlK8kb3uNJ3O34awkhtUlWHsK7HupZoe72vGW
        HuQ1oUojsQ2tfW07JcQe0qwYzhZXgOUngI+fvVTwSdRCBKjcQyiDcJCdkpcd3EC4NuG0YNJ+xPhW4
        0bctjsMvLZQj7OWoEx4iZkDLCuAeUdTVi8Qc0RK1JM43MFhXqjSoaL8bZPPrn7B5FzGm1YtsMjWVp
        qoRZMwQA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv8Xp-00Egk3-B8; Thu, 09 Dec 2021 01:48:25 +0000
Date:   Wed, 8 Dec 2021 17:48:25 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     tj@kernel.org, akpm@linux-foundation.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH v9 3/6] selftests: add tests_sysfs module
Message-ID: <YbFgaSPPw4Y3pJoB@bombadil.infradead.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-4-mcgrof@kernel.org>
 <Yao3vtSKBKLyQY1E@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yao3vtSKBKLyQY1E@kroah.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 03, 2021 at 04:29:02PM +0100, Greg KH wrote:
> On Fri, Oct 29, 2021 at 11:44:57AM -0700, Luis Chamberlain wrote:
> > This adds a new selftest module which can be used to test sysfs, which
> > would otherwise require using an existing driver. This lets us muck
> > with a template driver to test breaking things without affecting
> > system behaviour or requiring the dependencies of a real device
> > driver.
> 
> Test sysfs "how"?  What exactly are you wanting to test?

You can look at the 32 tests added after all patches applied.

> I see lots of things in this code as examples of how to NOT use sysfs,
> so are you testing my review cycles?  :)

You are exagerating, there are 32 tests there and only 2 tests deal
with a deadlock which we are not yet sure how widespread it could be.

> > A series of 28 tests are added. Support for using two device types are
> > supported:
> > 
> >   * misc
> >   * block
> 
> So you are testing the misc and block sysfs apis from within the kernel?

The reason for these two was to replicate typical driver setups and
environments.

> > Contrary to sysctls, sysfs requires a full write to happen at once, and
> > so we reduce the digit tests to single writes. Two main sysfs knobs are
> > provided for testing reading/storing, one which doesn't incur any
> > delays and another which can incur programmed delays. What locks are
> > held, if any, are configurable, at module load time, or through dynamic
> > configuration at run time.
> 
> I do not understand this paragraph at all.  What are you trying to say?
>
> sysfs is a read/write api, yes.  That's all, nothing fancy.  What does
> delays have to do with anything?

It is trying to clarify why tools/testing/selftests/sysctl/sysctl.sh
tests are different than    tools/testing/selftests/sysfs/sysfs.sh

> > Since sysfs is a technically filesystem, but a pseudo one, which
> > requires a kernel user, our test_sysfs module and respective test script
> > embraces fstests format for tests in the kernel ring bufffer. Likewise,
> > a scraper for kernel crashes is provided which matches what fstests does
> > as well.
> 
> What is crashing?

The kernel can crash. If it crashes then we want something to pick that up.

> > Two tests are kept disabled as they are a demonstration of what not to
> > do as it can cause a deadlock with sysfs. These tests provides a mechanism
> > to easily show proof and demo how the deadlock can happen:
> 
> Yes you can do foolish things in sysfs, but why are you limiting
> yourself to just 2 ways to shoot yourself in the foot?
>
> Again, I do not understand the goal here at all.  What is this file for?

Because clearly evidence is showing that *this* way to shoot yourself
in the foot was not clear and documented as not allowed and why. Petr
summarized the things which we need to document in a generic form:

http://lkml.kernel.org/r/YYFYFrnhwPiyOtst@alley

> > diff --git a/lib/test_sysfs.c b/lib/test_sysfs.c
> > new file mode 100644
> > index 000000000000..2a6ec072da60
> > --- /dev/null
> > +++ b/lib/test_sysfs.c
> > @@ -0,0 +1,894 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
> 
> Again, sorry, but no, I am going to object to this license as you are
> only accessing a GPL-v2-only api.  Any other license on a file that
> interacts with that, especially for core stuff like testing the
> functionality of this code, needs to have that same license.  Sorry.

Huh? The license is GPL-v2 compatible, and when used in the kernel the
GPLv2 applies.

Likewise, are you taking the position that permissively licensed code,
say BSD or ISC licensed code, cannot use EXPORT_SYMBOL_GPL() symbols?

> > +/*
> > + * Copyright (C) 2021 Luis Chamberlain <mcgrof@kernel.org>
> > + *
> > + * sysfs test driver
> > + *
> > + * This module allows us to add race conditions which we can test for
> > + * against the sysfs filesystem.
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/init.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/printk.h>
> > +#include <linux/fs.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/slab.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/async.h>
> > +#include <linux/delay.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/rtnetlink.h>
> > +#include <linux/genhd.h>
> > +#include <linux/blkdev.h>
> > +
> > +static bool enable_lock;
> > +module_param(enable_lock, bool_enable_only, 0644);
> > +MODULE_PARM_DESC(enable_lock,
> > +		 "enable locking on reads / stores from the start");
> 
> This isn't the 1990's why have module parameters when you are dealing
> with sysfs?  :)

It makes it easier for a test to specify its requirements from
the start. But yes these have respective device attributes too.

> > +static int sysfs_test_major;
> > +
> > +/**
> > + * test_config - used for configuring how the sysfs test device will behave
> > + *
> > + * @enable_lock: if enabled a lock will be used when reading/storing variables
> > + * @enable_lock_on_rmmod: if enabled a lock will be used when reading/storing
> > + *	sysfs attributes, but it will also be used to lock on rmmod. This is
> > + *	useful to test for a deadlock and should serve as an example of what
> > + *	drivers should *not* do.
> > + * @use_rtnl_lock: if enabled instead of configuration specific mutex, we'll
> > + *	use the rtnl_lock. If your test case is modifying this on the fly
> > + *	while doing other stores / reads, things will break as a lock can be
> > + *	left contending. Best is that tests use this knob serially, without
> > + *	allowing userspace to modify other knobs while this one changes.
> 
> Why are any of these locks needed at all?  What are you trying to test?
> How badly this code abuses locks and sysfs?
> 
> I do not understand how locking models matter to how the sysfs api works
> at all.

The rules summarized by Petr are things we need to document, this
demonstrates *why*.

> Again, what exactly are you trying to test?  What portions of the sysfs
> api?  I see misc and block device interactions here, those have
> different apis and have nothing to do with sysfs other than they too
> have sysfs interactions.

The way different misc / block devices *register* device attributes vary.
It is why both are used.

> If you want to test the sysfs api, that's great, but that is not what
> you are doing here, it's a mis/match of block/misc bad things.

After several tests, yes it does not matter which one you use.
But you are ignoring the tests mimic what we have been doing for
sysctls testing as well.

> > + * @write_delay_msec_y: the amount of delay to use when writing to y
> > + * @enable_busy_alloc: if enabled we'll do a large allocation between
> > + *	writes. We immediately free right away. We also schedule to give the
> > + *	kernel some time to re-use any memory we don't need. This is intened
> > + *	to mimic typical driver behaviour.
> > + */
> > +struct test_config {
> > +	bool enable_lock;
> > +	bool enable_lock_on_rmmod;
> > +	bool use_rtnl_lock;
> > +	unsigned int write_delay_msec_y;
> > +	bool enable_busy_alloc;
> > +};
> > +
> > +/**
> > + * enum sysfs_test_devtype - sysfs device type
> > + * @TESTDEV_TYPE_MISC: misc device type
> > + * @TESTDEV_TYPE_BLOCK: use a block device for the sysfs test device.
> > + */
> > +enum sysfs_test_devtype {
> > +	TESTDEV_TYPE_MISC = 0,
> > +	TESTDEV_TYPE_BLOCK,
> > +};
> > +
> > +/**
> > + * sysfs_test_device - test device to help test sysfs
> > + *
> > + * @devtype: the type of device to use
> > + * @config: configuration for the test
> > + * @config_mutex: protects configuration of test
> > + * @misc_dev: we use a misc device under the hood
> > + * @disk: represents a disk when used as a block device
> > + * @dev: pointer to misc_dev's own struct device
> > + * @dev_idx: unique ID for test device
> > + * @x: variable we can use to test read / store
> > + * @y: slow variable we can use to test read / store
> > + */
> > +struct sysfs_test_device {
> > +	enum sysfs_test_devtype devtype;
> > +	struct test_config config;
> > +	struct mutex config_mutex;
> > +	struct miscdevice misc_dev;
> > +	struct gendisk *disk;
> > +	struct device *dev;
> 
> So you have one device that controls the lifecycle (misc_dev) and then
> pointers to 2 others with different lifecycles?  That's odd.
> 
> And dev is not needed at all, please drop.

I use it to shortcut to the respective dev_to_test_dev() which can be
misc or block.

> > +	int dev_idx;
> > +	int x;
> > +	int y;
> > +};
> > +
> > +static struct sysfs_test_device *first_test_dev;
> > +
> > +static struct miscdevice *dev_to_misc_dev(struct device *dev)
> > +{
> > +	return dev_get_drvdata(dev);
> > +}
> > +
> > +static struct sysfs_test_device *misc_dev_to_test_dev(struct miscdevice *misc_dev)
> > +{
> > +	return container_of(misc_dev, struct sysfs_test_device, misc_dev);
> > +}
> > +
> > +static struct sysfs_test_device *devblock_to_test_dev(struct device *dev)
> > +{
> > +	return (struct sysfs_test_device *)dev_to_disk(dev)->private_data;
> > +}
> > +
> > +static struct sysfs_test_device *devmisc_to_testdev(struct device *dev)
> > +{
> > +	struct miscdevice *misc_dev;
> > +
> > +	misc_dev = dev_to_misc_dev(dev);
> > +	return misc_dev_to_test_dev(misc_dev);
> > +}
> > +
> > +static struct sysfs_test_device *dev_to_test_dev(struct device *dev)
> > +{
> > +	if (test_devtype == TESTDEV_TYPE_MISC)
> > +		return devmisc_to_testdev(dev);
> > +	else if (test_devtype == TESTDEV_TYPE_BLOCK)
> > +		return devblock_to_test_dev(dev);
> > +	return NULL;
> > +}
> > +
> > +static void test_dev_config_lock(struct sysfs_test_device *test_dev)
> > +{
> > +	struct test_config *config = &test_dev->config;
> > +
> > +	if (config->enable_lock) {
> > +		if (config->use_rtnl_lock)
> > +			rtnl_lock();
> > +		else
> > +			mutex_lock(&test_dev->config_mutex);
> > +	}
> > +}
> > +
> > +static void test_dev_config_unlock(struct sysfs_test_device *test_dev)
> > +{
> > +	struct test_config *config = &test_dev->config;
> > +
> > +	if (config->enable_lock) {
> > +		if (config->use_rtnl_lock)
> > +			rtnl_unlock();
> > +		else
> > +			mutex_unlock(&test_dev->config_mutex);
> > +	}
> > +}
> > +
> > +static void test_dev_config_lock_rmmod(struct sysfs_test_device *test_dev)
> > +{
> > +	struct test_config *config = &test_dev->config;
> > +
> > +	if (config->enable_lock_on_rmmod)
> > +		test_dev_config_lock(test_dev);
> > +}
> > +
> > +static void test_dev_config_unlock_rmmod(struct sysfs_test_device *test_dev)
> > +{
> > +	struct test_config *config = &test_dev->config;
> > +
> > +	if (config->enable_lock_on_rmmod)
> > +		test_dev_config_unlock(test_dev);
> > +}
> > +
> > +static void free_test_dev_sysfs(struct sysfs_test_device *test_dev)
> > +{
> > +	if (test_dev) {
> > +		kfree_const(test_dev->misc_dev.name);
> > +		test_dev->misc_dev.name = NULL;
> > +		kfree(test_dev);
> > +		test_dev = NULL;
> > +	}
> > +}
> > +
> > +static void test_sysfs_reset_vals(struct sysfs_test_device *test_dev)
> > +{
> > +	test_dev->x = 3;
> > +	test_dev->y = 4;
> > +}
> > +
> > +static ssize_t config_show(struct device *dev,
> > +			   struct device_attribute *attr,
> > +			   char *buf)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +	int len = 0;
> > +
> > +	test_dev_config_lock(test_dev);
> > +
> > +	len += sysfs_emit_at(buf, len, "Configuration for: %s\n",
> > +			     dev_name(dev));
> > +	len += sysfs_emit_at(buf, len, "x:\t%d\n", test_dev->x);
> > +	len += sysfs_emit_at(buf, len, "y:\t%d\n", test_dev->y);
> > +	len += sysfs_emit_at(buf, len, "enable_lock:\t%s\n",
> > +			     config->enable_lock ? "true" : "false");
> > +	len += sysfs_emit_at(buf, len, "enable_lock_on_rmmmod:\t%s\n",
> > +			     config->enable_lock_on_rmmod ? "true" : "false");
> > +	len += sysfs_emit_at(buf, len, "use_rtnl_lock:\t%s\n",
> > +			     config->use_rtnl_lock ? "true" : "false");
> > +	len += sysfs_emit_at(buf, len, "write_delay_msec_y:\t%d\n",
> > +			     config->write_delay_msec_y);
> > +	len += sysfs_emit_at(buf, len, "enable_busy_alloc:\t%s\n",
> > +			     config->enable_busy_alloc ? "true" : "false");
> > +	len += sysfs_emit_at(buf, len, "enable_debugfs:\t%s\n",
> > +			     enable_debugfs ? "true" : "false");
> > +	len += sysfs_emit_at(buf, len, "enable_verbose_writes:\t%s\n",
> > +			     enable_verbose_writes ? "true" : "false");
> 
> sysfs is one-value-per-file.  This is a huge violation of it and is not
> allowed at all.  This function alone would cause me to reject it :(

Huh? You make no sense. I am not allowing folks to input / write a full
config here to this one file, this is just a read-only trigger to output
the full configuration for the test. This makes it easy to read. And I
already have similar methodology for my other selftests.

> Also, you are creating sysfs files, where are the Documentation/ABI/
> entries?

These are selftests, there is no ABI. The ABI if you will *is* parity
with the selftest script. And those tests remain compatible with older
kernels.

> > +
> > +	test_dev_config_unlock(test_dev);
> > +
> > +	return len;
> > +}
> > +static DEVICE_ATTR_RO(config);
> > +
> > +static ssize_t reset_store(struct device *dev,
> > +			   struct device_attribute *attr,
> > +			   const char *buf, size_t count)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +
> > +	/*
> > +	 * We compromise and simplify this condition and do not use a lock
> > +	 * here as the lock type can change.
> > +	 */
> > +	config->enable_lock = false;
> > +	config->enable_lock_on_rmmod = false;
> > +	config->use_rtnl_lock = false;
> > +	config->enable_busy_alloc = false;
> > +	test_sysfs_reset_vals(test_dev);
> 
> I do not understand how a lock matters here.

Because you can technically race two scripts trying to configure
one knob, while this just tries to reset to defaults. So since
we are a selftest, and we design *how* we run the test we have
control over the fact that the way we design the test this racy
behaviour won't happen as we are not designing the test to
do that.

> And you can accept any data at all?  That's not a valid test :(

Who cares, yes, I am.

> > +
> > +	dev_info(dev, "reset\n");
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_WO(reset);
> > +
> > +static void test_dev_busy_alloc(struct sysfs_test_device *test_dev)
> > +{
> > +	struct test_config *config = &test_dev->config;
> > +	char *ignore;
> > +
> > +	if (!config->enable_busy_alloc)
> > +		return;
> > +
> > +	ignore = kzalloc(sizeof(struct sysfs_test_device) * 10, GFP_KERNEL);
> > +	kfree(ignore);
> > +
> > +	schedule();
> > +}
> > +
> > +static ssize_t test_dev_x_store(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf, size_t count)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	int ret;
> > +
> > +	test_dev_busy_alloc(test_dev);
> > +	test_dev_config_lock(test_dev);
> > +
> > +	ret = kstrtoint(buf, 10, &test_dev->x);
> > +	if (ret)
> > +		count = ret;
> > +
> > +	if (enable_verbose_writes)
> > +		dev_info(test_dev->dev, "wrote x = %d\n", test_dev->x);
> > +
> > +	test_dev_config_unlock(test_dev);
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t test_dev_x_show(struct device *dev,
> > +			       struct device_attribute *attr,
> > +			       char *buf)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	int ret;
> > +
> > +	test_dev_config_lock(test_dev);
> > +	ret = sysfs_emit(buf, "%d\n", test_dev->x);
> > +	test_dev_config_unlock(test_dev);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RW(test_dev_x);
> > +
> > +static ssize_t test_dev_y_store(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf, size_t count)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config;
> > +	int y;
> > +	int ret;
> > +
> > +	test_dev_busy_alloc(test_dev);
> > +	test_dev_config_lock(test_dev);
> > +
> > +	config = &test_dev->config;
> > +
> > +	ret = kstrtoint(buf, 10, &y);
> > +	if (ret)
> > +		count = ret;
> > +
> > +	msleep(config->write_delay_msec_y);
> > +	test_dev->y = test_dev->x + y + 7;
> 
> What is "7" for?

It does not matter what value, you just need to set a value
which userspace can know / expect for a test.

> > +
> > +	if (enable_verbose_writes)
> > +		dev_info(test_dev->dev, "wrote y = %d\n", test_dev->y);
> > +
> > +	test_dev_config_unlock(test_dev);
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t test_dev_y_show(struct device *dev,
> > +			       struct device_attribute *attr,
> > +			       char *buf)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	int ret;
> > +
> > +	test_dev_config_lock(test_dev);
> > +	ret = sysfs_emit(buf, "%d\n", test_dev->y);
> > +	test_dev_config_unlock(test_dev);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RW(test_dev_y);
> > +
> > +static ssize_t config_enable_lock_store(struct device *dev,
> > +					struct device_attribute *attr,
> > +					const char *buf, size_t count)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +	int ret;
> > +	int val;
> > +
> > +	ret = kstrtoint(buf, 10, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * We compromise for simplicty and do not lock when changing
> > +	 * locking configuration, with the assumption userspace tests
> > +	 * will know this.
> > +	 */
> > +	if (val)
> > +		config->enable_lock = true;
> > +	else
> > +		config->enable_lock = false;
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t config_enable_lock_show(struct device *dev,
> > +				       struct device_attribute *attr,
> > +				       char *buf)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +	ssize_t ret;
> > +
> > +	test_dev_config_lock(test_dev);
> > +	ret = sysfs_emit(buf, "%d\n", config->enable_lock);
> > +	test_dev_config_unlock(test_dev);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RW(config_enable_lock);
> > +
> > +static ssize_t config_enable_lock_on_rmmod_store(struct device *dev,
> > +						 struct device_attribute *attr,
> > +						 const char *buf, size_t count)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +	int ret;
> > +	int val;
> > +
> > +	ret = kstrtoint(buf, 10, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	test_dev_config_lock(test_dev);
> > +	if (val)
> > +		config->enable_lock_on_rmmod = true;
> > +	else
> > +		config->enable_lock_on_rmmod = false;
> > +	test_dev_config_unlock(test_dev);
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t config_enable_lock_on_rmmod_show(struct device *dev,
> > +						struct device_attribute *attr,
> > +						char *buf)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +	ssize_t ret;
> > +
> > +	test_dev_config_lock(test_dev);
> > +	ret = sysfs_emit(buf, "%d\n", config->enable_lock_on_rmmod);
> > +	test_dev_config_unlock(test_dev);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_RW(config_enable_lock_on_rmmod);
> > +
> > +static ssize_t config_use_rtnl_lock_store(struct device *dev,
> > +					  struct device_attribute *attr,
> > +					  const char *buf, size_t count)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +	int ret;
> > +	int val;
> > +
> > +	ret = kstrtoint(buf, 10, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * We compromise and simplify this condition and do not use a lock
> > +	 * here as the lock type can change.
> > +	 */
> > +	if (val)
> > +		config->use_rtnl_lock = true;
> > +	else
> > +		config->use_rtnl_lock = false;
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t config_use_rtnl_lock_show(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 char *buf)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +
> > +	return sysfs_emit(buf, "%d\n", config->use_rtnl_lock);
> > +}
> > +static DEVICE_ATTR_RW(config_use_rtnl_lock);
> > +
> > +static ssize_t config_write_delay_msec_y_store(struct device *dev,
> > +					       struct device_attribute *attr,
> > +					       const char *buf, size_t count)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +	int ret;
> > +	int val;
> > +
> > +	ret = kstrtoint(buf, 10, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	test_dev_config_lock(test_dev);
> > +	config->write_delay_msec_y = val;
> > +	test_dev_config_unlock(test_dev);
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t config_write_delay_msec_y_show(struct device *dev,
> > +					      struct device_attribute *attr,
> > +					      char *buf)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +
> > +	return sysfs_emit(buf, "%d\n", config->write_delay_msec_y);
> > +}
> > +static DEVICE_ATTR_RW(config_write_delay_msec_y);
> > +
> > +static ssize_t config_enable_busy_alloc_store(struct device *dev,
> > +					      struct device_attribute *attr,
> > +					      const char *buf, size_t count)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +	int ret;
> > +	int val;
> > +
> > +	ret = kstrtoint(buf, 10, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	test_dev_config_lock(test_dev);
> > +	config->enable_busy_alloc = val;
> > +	test_dev_config_unlock(test_dev);
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t config_enable_busy_alloc_show(struct device *dev,
> > +					     struct device_attribute *attr,
> > +					     char *buf)
> > +{
> > +	struct sysfs_test_device *test_dev = dev_to_test_dev(dev);
> > +	struct test_config *config = &test_dev->config;
> > +
> > +	return sysfs_emit(buf, "%d\n", config->enable_busy_alloc);
> > +}
> > +static DEVICE_ATTR_RW(config_enable_busy_alloc);
> > +
> > +#define TEST_SYSFS_DEV_ATTR(name)		(&dev_attr_##name.attr)
> 
> Just spell it out please, no need for a macro.

I've been doing that for years for my other selftests.

> > +
> > +static struct attribute *test_dev_attrs[] = {
> > +	/* Generic driver knobs go here */
> > +	TEST_SYSFS_DEV_ATTR(config),
> > +	TEST_SYSFS_DEV_ATTR(reset),
> > +
> > +	/* These are used to test sysfs */
> > +	TEST_SYSFS_DEV_ATTR(test_dev_x),
> > +	TEST_SYSFS_DEV_ATTR(test_dev_y),
> > +
> > +	/*
> > +	 * These are configuration knobs to modify how we test sysfs when
> > +	 * doing reads / stores.
> > +	 */
> > +	TEST_SYSFS_DEV_ATTR(config_enable_lock),
> > +	TEST_SYSFS_DEV_ATTR(config_enable_lock_on_rmmod),
> > +	TEST_SYSFS_DEV_ATTR(config_use_rtnl_lock),
> > +	TEST_SYSFS_DEV_ATTR(config_write_delay_msec_y),
> > +	TEST_SYSFS_DEV_ATTR(config_enable_busy_alloc),
> > +
> > +	NULL,
> > +};
> > +
> > +ATTRIBUTE_GROUPS(test_dev);
> 
> That's a weak "test" of how attribute groups work and how they can work.
> It's pretty much the simplest way.  why?

I'm not testing attribute groups here yet in this selftest other than
this simple case. So far this selftests is testing reads/writes and
races.

We can later extend how we we define attribute groups and do crazy
things.

> > +static int sysfs_test_dev_alloc_miscdev(struct sysfs_test_device *test_dev)
> > +{
> > +	struct miscdevice *misc_dev;
> > +
> > +	misc_dev = &test_dev->misc_dev;
> > +	misc_dev->minor = MISC_DYNAMIC_MINOR;
> > +	misc_dev->name = kasprintf(GFP_KERNEL, "test_sysfs%d", test_dev->dev_idx);
> > +	if (!misc_dev->name) {
> > +		pr_err("Cannot alloc misc_dev->name\n");
> > +		return -ENOMEM;
> > +	}
> > +	misc_dev->groups = test_dev_groups;
> > +
> > +	return 0;
> > +}
> > +
> > +static int testdev_open(struct block_device *bdev, fmode_t mode)
> > +{
> > +	return -EINVAL;
> 
> Why?

Because we don't need it. We just want to borrow the way the block
layer registers attributes.

> > +}
> > +
> > +static void testdev_submit_bio(struct bio *bio)
> > +{
> > +}
> 
> Huh?

We don't need that either.
> 
> > +
> > +static void testdev_slot_free_notify(struct block_device *bdev,
> > +				     unsigned long index)
> > +{
> > +}
> 
> Why nothing?

And so one, becuase we just want to borrow the same path used
to register attributes from the block layer.

> 
> > +
> > +static int testdev_rw_page(struct block_device *bdev, sector_t sector,
> > +			   struct page *page, unsigned int op)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> 
> What is this doing?

Obviously nothing.

> > +
> > +static const struct block_device_operations sysfs_testdev_ops = {
> > +	.open = testdev_open,
> > +	.submit_bio = testdev_submit_bio,
> > +	.swap_slot_free_notify = testdev_slot_free_notify,
> > +	.rw_page = testdev_rw_page,
> > +	.owner = THIS_MODULE
> > +};
> > +
> > +static int sysfs_test_dev_alloc_blockdev(struct sysfs_test_device *test_dev)
> > +{
> > +	int ret = -ENOMEM;
> > +
> > +	test_dev->disk = blk_alloc_disk(NUMA_NO_NODE);
> > +	if (!test_dev->disk) {
> > +		pr_err("Error allocating disk structure for device %d\n",
> > +		       test_dev->dev_idx);
> > +		goto out;
> > +	}
> > +
> > +	test_dev->disk->major = sysfs_test_major;
> > +	test_dev->disk->first_minor = test_dev->dev_idx + 1;
> > +	test_dev->disk->fops = &sysfs_testdev_ops;
> > +	test_dev->disk->private_data = test_dev;
> > +	snprintf(test_dev->disk->disk_name, sizeof(test_dev->disk->disk_name),
> > +		 "test_sysfs%d", test_dev->dev_idx);
> > +	set_capacity(test_dev->disk, 0);
> > +	blk_queue_flag_set(QUEUE_FLAG_NONROT, test_dev->disk->queue);
> > +	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, test_dev->disk->queue);
> > +	blk_queue_physical_block_size(test_dev->disk->queue, PAGE_SIZE);
> > +	blk_queue_max_discard_sectors(test_dev->disk->queue, UINT_MAX);
> > +	blk_queue_flag_set(QUEUE_FLAG_DISCARD, test_dev->disk->queue);
> > +
> > +	return 0;
> > +out:
> > +	return ret;
> > +}
> 
> What does this block device do?

Nothing. We are borrowing the way we register the sysfs attributes.

> > +
> > +static struct sysfs_test_device *alloc_test_dev_sysfs(int idx)
> > +{
> > +	struct sysfs_test_device *test_dev;
> > +	int ret;
> > +
> > +	switch (test_devtype) {
> > +	case TESTDEV_TYPE_MISC:
> > +	       fallthrough;
> > +	case TESTDEV_TYPE_BLOCK:
> > +		break;
> 
> That's the only 2 types you have, why test?

That suffices for now. This is only an initial set of tests. If we come
up with another driver odd case and want to try to see if we can
reproduce the issue in a clean form we can do it here by expanding on
the types.

> > +	default:
> > +		return NULL;
> > +	}
> > +
> > +	test_dev = kzalloc(sizeof(struct sysfs_test_device), GFP_KERNEL);
> > +	if (!test_dev)
> > +		goto err_out;
> > +
> > +	mutex_init(&test_dev->config_mutex);
> > +	test_dev->dev_idx = idx;
> > +	test_dev->devtype = test_devtype;
> > +
> > +	if (test_dev->devtype == TESTDEV_TYPE_MISC) {
> > +		ret = sysfs_test_dev_alloc_miscdev(test_dev);
> > +		if (ret)
> > +			goto err_out_free;
> > +	} else if (test_dev->devtype == TESTDEV_TYPE_BLOCK) {
> > +		ret = sysfs_test_dev_alloc_blockdev(test_dev);
> > +		if (ret)
> > +			goto err_out_free;
> > +	}
> > +	return test_dev;
> > +
> > +err_out_free:
> > +	kfree(test_dev);
> > +	test_dev = NULL;
> > +err_out:
> > +	return NULL;
> > +}
> > +
> > +static int register_test_dev_sysfs_misc(struct sysfs_test_device *test_dev)
> > +{
> > +	int ret;
> > +
> > +	ret = misc_register(&test_dev->misc_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	test_dev->dev = test_dev->misc_dev.this_device;
> 
> Why are you messing with the internals of a misc device's struct device?
> That's not for anyone to play with.

That's so we can easily get to the struct sysfs_test_device from the
device with dev_to_test_dev().

> > +
> > +	return 0;
> > +}
> > +
> > +static int register_test_dev_sysfs_block(struct sysfs_test_device *test_dev)
> > +{
> > +	int ret;
> > +
> > +	ret = device_add_disk(NULL, test_dev->disk, test_dev_groups);
> > +	if (ret) {
> > +		blk_cleanup_disk(test_dev->disk);
> > +		return ret;
> > +	}
> > +
> > +	test_dev->dev = disk_to_dev(test_dev->disk);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct sysfs_test_device *register_test_dev_sysfs(void)
> > +{
> > +	struct sysfs_test_device *test_dev = NULL;
> > +	int ret;
> > +
> > +	test_dev = alloc_test_dev_sysfs(0);
> > +	if (!test_dev)
> > +		goto out;
> > +
> > +	if (test_dev->devtype == TESTDEV_TYPE_MISC) {
> > +		ret = register_test_dev_sysfs_misc(test_dev);
> > +		if (ret) {
> > +			pr_err("could not register misc device: %d\n", ret);
> > +			goto out_free_dev;
> > +		}
> > +	} else if (test_dev->devtype == TESTDEV_TYPE_BLOCK) {
> > +		ret = register_test_dev_sysfs_block(test_dev);
> > +		if (ret) {
> > +			pr_err("could not register block device: %d\n", ret);
> > +			goto out_free_dev;
> > +		}
> > +	}
> > +
> > +	dev_info(test_dev->dev, "interface ready\n");
> > +
> > +out:
> > +	return test_dev;
> > +out_free_dev:
> > +	free_test_dev_sysfs(test_dev);
> > +	return NULL;
> > +}
> > +
> > +static struct sysfs_test_device *register_test_dev_set_config(void)
> > +{
> > +	struct sysfs_test_device *test_dev;
> > +	struct test_config *config;
> > +
> > +	test_dev = register_test_dev_sysfs();
> > +	if (!test_dev)
> > +		return NULL;
> > +
> > +	config = &test_dev->config;
> > +
> > +	if (enable_lock)
> > +		config->enable_lock = true;
> > +	if (enable_lock_on_rmmod)
> > +		config->enable_lock_on_rmmod = true;
> > +	if (use_rtnl_lock)
> > +		config->use_rtnl_lock = true;
> > +	if (enable_busy_alloc)
> > +		config->enable_busy_alloc = true;
> > +
> > +	config->write_delay_msec_y = write_delay_msec_y;
> > +	test_sysfs_reset_vals(test_dev);
> > +
> > +	return test_dev;
> > +}
> > +
> > +static void unregister_test_dev_sysfs_misc(struct sysfs_test_device *test_dev)
> > +{
> > +	misc_deregister(&test_dev->misc_dev);
> > +}
> > +
> > +static void unregister_test_dev_sysfs_block(struct sysfs_test_device *test_dev)
> > +{
> > +	del_gendisk(test_dev->disk);
> > +	blk_cleanup_disk(test_dev->disk);
> > +}
> > +
> > +static void unregister_test_dev_sysfs(struct sysfs_test_device *test_dev)
> > +{
> > +	test_dev_config_lock_rmmod(test_dev);
> > +
> > +	dev_info(test_dev->dev, "removing interface\n");
> > +
> > +	if (test_dev->devtype == TESTDEV_TYPE_MISC)
> > +		unregister_test_dev_sysfs_misc(test_dev);
> > +	else if (test_dev->devtype == TESTDEV_TYPE_BLOCK)
> > +		unregister_test_dev_sysfs_block(test_dev);
> > +
> > +	test_dev_config_unlock_rmmod(test_dev);
> > +
> > +	free_test_dev_sysfs(test_dev);
> > +}
> > +
> > +static struct dentry *debugfs_dir;
> 
> Why get debugfs involved?

I did that so to allow caling unregister_test_dev_sysfs_misc() and
unregister_test_dev_sysfs_block() *outside* of being tied to the
same sysfs attributes from the block/char device being registered.
In other words we would not be able to do that from sysfs files
for obvious reasons.

> > +/* When read represents how many times we have reset the first_test_dev */
> > +static u8 reset_first_test_dev;
> > +
> > +static ssize_t read_reset_first_test_dev(struct file *file,
> > +					 char __user *user_buf,
> > +					 size_t count, loff_t *ppos)
> > +{
> > +	ssize_t len;
> > +	char buf[32];
> > +
> > +	reset_first_test_dev++;
> > +	len = sprintf(buf, "%d\n", reset_first_test_dev);
> > +	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
> > +}
> > +
> > +static ssize_t write_reset_first_test_dev(struct file *file,
> > +					  const char __user *user_buf,
> > +					  size_t count, loff_t *ppos)
> > +{
> > +	if (!try_module_get(THIS_MODULE))
> 
> Totally racy, broken, and not allowed, sorry.

It is needed, given what this is trying to do.

  Luis
