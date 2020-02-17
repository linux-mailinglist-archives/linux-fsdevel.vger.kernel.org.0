Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11C161717
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgBQQMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FDO8dIrow+kQ1p3OE/iX0Ma8BirKgi5EBTlTgeO91S8=; b=WmmoJvXFYW6sz1N+josOahklRi
        1svtjZiO+Yu5UADrmN0+BYDRbfZjGSQ3PqRei7ixfMSEelr/rTvTR7KF79gJIBQxxpBUWBNf/pmYc
        6dCHwwVfgqpHnJnlxWnrFCUMCCRkxhhMkkI07cJIDjN4KehH/2txG2eguO5rGtlka5INBXPpA6Fvi
        8SWRJuj+RhlJv75b7OUkb7WVOoOYuvTDw2XIw3lvKYEGVz2pGBooR9DHA51rWLAfXAeFlAutGCEYe
        5aZW6ZiiQpCjQDJ/xwFNVqYfMhxi+BdcLsjvp1T75IZ+swPjLcHC38XP8UFqUbNcfxOv1hPTjwfKa
        T6zsB5fg==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0d-0006v0-6M; Mon, 17 Feb 2020 16:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fbz-9V; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 38/44] docs: filesystems: convert sysfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:24 +0100
Message-Id: <5c480dcb467315b5df6e25372a65e473b585c36d.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;
- Add a document title;
- Adjust document and section titles;
- use :field: markup;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |   1 +
 .../filesystems/{sysfs.txt => sysfs.rst}      | 324 +++++++++---------
 2 files changed, 168 insertions(+), 157 deletions(-)
 rename Documentation/filesystems/{sysfs.txt => sysfs.rst} (56%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 97a5f65ae509..bafe92c72433 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -87,5 +87,6 @@ Documentation for filesystem implementations.
    relay
    romfs
    squashfs
+   sysfs
    virtiofs
    vfat
diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.rst
similarity index 56%
rename from Documentation/filesystems/sysfs.txt
rename to Documentation/filesystems/sysfs.rst
index ddf15b1b0d5a..290891c3fecb 100644
--- a/Documentation/filesystems/sysfs.txt
+++ b/Documentation/filesystems/sysfs.rst
@@ -1,32 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-sysfs - _The_ filesystem for exporting kernel objects. 
+=====================================================
+sysfs - _The_ filesystem for exporting kernel objects
+=====================================================
 
 Patrick Mochel	<mochel@osdl.org>
+
 Mike Murphy <mamurph@cs.clemson.edu>
 
-Revised:    16 August 2011
-Original:   10 January 2003
+:Revised:    16 August 2011
+:Original:   10 January 2003
 
 
 What it is:
 ~~~~~~~~~~~
 
 sysfs is a ram-based filesystem initially based on ramfs. It provides
-a means to export kernel data structures, their attributes, and the 
-linkages between them to userspace. 
+a means to export kernel data structures, their attributes, and the
+linkages between them to userspace.
 
 sysfs is tied inherently to the kobject infrastructure. Please read
 Documentation/kobject.txt for more information concerning the kobject
-interface. 
+interface.
 
 
 Using sysfs
 ~~~~~~~~~~~
 
 sysfs is always compiled in if CONFIG_SYSFS is defined. You can access
-it by doing:
+it by doing::
 
-    mount -t sysfs sysfs /sys 
+    mount -t sysfs sysfs /sys
 
 
 Directory Creation
@@ -37,7 +41,7 @@ created for it in sysfs. That directory is created as a subdirectory
 of the kobject's parent, expressing internal object hierarchies to
 userspace. Top-level directories in sysfs represent the common
 ancestors of object hierarchies; i.e. the subsystems the objects
-belong to. 
+belong to.
 
 Sysfs internally stores a pointer to the kobject that implements a
 directory in the kernfs_node object associated with the directory. In
@@ -58,63 +62,63 @@ attributes.
 Attributes should be ASCII text files, preferably with only one value
 per file. It is noted that it may not be efficient to contain only one
 value per file, so it is socially acceptable to express an array of
-values of the same type. 
+values of the same type.
 
 Mixing types, expressing multiple lines of data, and doing fancy
 formatting of data is heavily frowned upon. Doing these things may get
-you publicly humiliated and your code rewritten without notice. 
+you publicly humiliated and your code rewritten without notice.
 
 
-An attribute definition is simply:
+An attribute definition is simply::
 
-struct attribute {
-        char                    * name;
-        struct module		*owner;
-        umode_t                 mode;
-};
+    struct attribute {
+	    char                    * name;
+	    struct module		*owner;
+	    umode_t                 mode;
+    };
 
 
-int sysfs_create_file(struct kobject * kobj, const struct attribute * attr);
-void sysfs_remove_file(struct kobject * kobj, const struct attribute * attr);
+    int sysfs_create_file(struct kobject * kobj, const struct attribute * attr);
+    void sysfs_remove_file(struct kobject * kobj, const struct attribute * attr);
 
 
 A bare attribute contains no means to read or write the value of the
 attribute. Subsystems are encouraged to define their own attribute
 structure and wrapper functions for adding and removing attributes for
-a specific object type. 
+a specific object type.
 
-For example, the driver model defines struct device_attribute like:
+For example, the driver model defines struct device_attribute like::
 
-struct device_attribute {
-	struct attribute	attr;
-	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
-			char *buf);
-	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count);
-};
+    struct device_attribute {
+	    struct attribute	attr;
+	    ssize_t (*show)(struct device *dev, struct device_attribute *attr,
+			    char *buf);
+	    ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count);
+    };
 
-int device_create_file(struct device *, const struct device_attribute *);
-void device_remove_file(struct device *, const struct device_attribute *);
+    int device_create_file(struct device *, const struct device_attribute *);
+    void device_remove_file(struct device *, const struct device_attribute *);
 
-It also defines this helper for defining device attributes: 
+It also defines this helper for defining device attributes::
 
-#define DEVICE_ATTR(_name, _mode, _show, _store) \
-struct device_attribute dev_attr_##_name = __ATTR(_name, _mode, _show, _store)
+    #define DEVICE_ATTR(_name, _mode, _show, _store) \
+    struct device_attribute dev_attr_##_name = __ATTR(_name, _mode, _show, _store)
 
-For example, declaring
+For example, declaring::
 
-static DEVICE_ATTR(foo, S_IWUSR | S_IRUGO, show_foo, store_foo);
+    static DEVICE_ATTR(foo, S_IWUSR | S_IRUGO, show_foo, store_foo);
 
-is equivalent to doing:
+is equivalent to doing::
 
-static struct device_attribute dev_attr_foo = {
-	.attr = {
-		.name = "foo",
-		.mode = S_IWUSR | S_IRUGO,
-	},
-	.show = show_foo,
-	.store = store_foo,
-};
+    static struct device_attribute dev_attr_foo = {
+	    .attr = {
+		    .name = "foo",
+		    .mode = S_IWUSR | S_IRUGO,
+	    },
+	    .show = show_foo,
+	    .store = store_foo,
+    };
 
 Note as stated in include/linux/kernel.h "OTHER_WRITABLE?  Generally
 considered a bad idea." so trying to set a sysfs file writable for
@@ -127,15 +131,21 @@ readable. The above case could be shortened to:
 static struct device_attribute dev_attr_foo = __ATTR_RW(foo);
 
 the list of helpers available to define your wrapper function is:
-__ATTR_RO(name): assumes default name_show and mode 0444
-__ATTR_WO(name): assumes a name_store only and is restricted to mode
+
+__ATTR_RO(name):
+		 assumes default name_show and mode 0444
+__ATTR_WO(name):
+		 assumes a name_store only and is restricted to mode
                  0200 that is root write access only.
-__ATTR_RO_MODE(name, mode): fore more restrictive RO access currently
+__ATTR_RO_MODE(name, mode):
+	         fore more restrictive RO access currently
                  only use case is the EFI System Resource Table
                  (see drivers/firmware/efi/esrt.c)
-__ATTR_RW(name): assumes default name_show, name_store and setting
+__ATTR_RW(name):
+	         assumes default name_show, name_store and setting
                  mode to 0644.
-__ATTR_NULL: which sets the name to NULL and is used as end of list
+__ATTR_NULL:
+	         which sets the name to NULL and is used as end of list
                  indicator (see: kernel/workqueue.c)
 
 Subsystem-Specific Callbacks
@@ -143,12 +153,12 @@ Subsystem-Specific Callbacks
 
 When a subsystem defines a new attribute type, it must implement a
 set of sysfs operations for forwarding read and write calls to the
-show and store methods of the attribute owners. 
+show and store methods of the attribute owners::
 
-struct sysfs_ops {
-        ssize_t (*show)(struct kobject *, struct attribute *, char *);
-        ssize_t (*store)(struct kobject *, struct attribute *, const char *, size_t);
-};
+    struct sysfs_ops {
+	    ssize_t (*show)(struct kobject *, struct attribute *, char *);
+	    ssize_t (*store)(struct kobject *, struct attribute *, const char *, size_t);
+    };
 
 [ Subsystems should have already defined a struct kobj_type as a
 descriptor for this type, which is where the sysfs_ops pointer is
@@ -157,29 +167,29 @@ stored. See the kobject documentation for more information. ]
 When a file is read or written, sysfs calls the appropriate method
 for the type. The method then translates the generic struct kobject
 and struct attribute pointers to the appropriate pointer types, and
-calls the associated methods. 
+calls the associated methods.
 
 
-To illustrate:
+To illustrate::
 
-#define to_dev(obj) container_of(obj, struct device, kobj)
-#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
+    #define to_dev(obj) container_of(obj, struct device, kobj)
+    #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
 
-static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
-                             char *buf)
-{
-        struct device_attribute *dev_attr = to_dev_attr(attr);
-        struct device *dev = to_dev(kobj);
-        ssize_t ret = -EIO;
+    static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
+				char *buf)
+    {
+	    struct device_attribute *dev_attr = to_dev_attr(attr);
+	    struct device *dev = to_dev(kobj);
+	    ssize_t ret = -EIO;
 
-        if (dev_attr->show)
-                ret = dev_attr->show(dev, dev_attr, buf);
-        if (ret >= (ssize_t)PAGE_SIZE) {
-                printk("dev_attr_show: %pS returned bad count\n",
-                                dev_attr->show);
-        }
-        return ret;
-}
+	    if (dev_attr->show)
+		    ret = dev_attr->show(dev, dev_attr, buf);
+	    if (ret >= (ssize_t)PAGE_SIZE) {
+		    printk("dev_attr_show: %pS returned bad count\n",
+				    dev_attr->show);
+	    }
+	    return ret;
+    }
 
 
 
@@ -188,11 +198,11 @@ Reading/Writing Attribute Data
 
 To read or write attributes, show() or store() methods must be
 specified when declaring the attribute. The method types should be as
-simple as those defined for device attributes:
+simple as those defined for device attributes::
 
-ssize_t (*show)(struct device *dev, struct device_attribute *attr, char *buf);
-ssize_t (*store)(struct device *dev, struct device_attribute *attr,
-                 const char *buf, size_t count);
+    ssize_t (*show)(struct device *dev, struct device_attribute *attr, char *buf);
+    ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count);
 
 IOW, they should take only an object, an attribute, and a buffer as parameters.
 
@@ -200,11 +210,11 @@ IOW, they should take only an object, an attribute, and a buffer as parameters.
 sysfs allocates a buffer of size (PAGE_SIZE) and passes it to the
 method. Sysfs will call the method exactly once for each read or
 write. This forces the following behavior on the method
-implementations: 
+implementations:
 
-- On read(2), the show() method should fill the entire buffer. 
+- On read(2), the show() method should fill the entire buffer.
   Recall that an attribute should only be exporting one value, or an
-  array of similar values, so this shouldn't be that expensive. 
+  array of similar values, so this shouldn't be that expensive.
 
   This allows userspace to do partial reads and forward seeks
   arbitrarily over the entire file at will. If userspace seeks back to
@@ -218,10 +228,10 @@ implementations:
 
   When writing sysfs files, userspace processes should first read the
   entire file, modify the values it wishes to change, then write the
-  entire buffer back. 
+  entire buffer back.
 
   Attribute method implementations should operate on an identical
-  buffer when reading and writing values. 
+  buffer when reading and writing values.
 
 Other notes:
 
@@ -229,7 +239,7 @@ Other notes:
   file position.
 
 - The buffer will always be PAGE_SIZE bytes in length. On i386, this
-  is 4096. 
+  is 4096.
 
 - show() methods should return the number of bytes printed into the
   buffer. This is the return value of scnprintf().
@@ -246,31 +256,31 @@ Other notes:
   through, be sure to return an error.
 
 - The object passed to the methods will be pinned in memory via sysfs
-  referencing counting its embedded object. However, the physical 
-  entity (e.g. device) the object represents may not be present. Be 
-  sure to have a way to check this, if necessary. 
+  referencing counting its embedded object. However, the physical
+  entity (e.g. device) the object represents may not be present. Be
+  sure to have a way to check this, if necessary.
 
 
-A very simple (and naive) implementation of a device attribute is:
+A very simple (and naive) implementation of a device attribute is::
 
-static ssize_t show_name(struct device *dev, struct device_attribute *attr,
-                         char *buf)
-{
-	return scnprintf(buf, PAGE_SIZE, "%s\n", dev->name);
-}
+    static ssize_t show_name(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+    {
+	    return scnprintf(buf, PAGE_SIZE, "%s\n", dev->name);
+    }
 
-static ssize_t store_name(struct device *dev, struct device_attribute *attr,
-                          const char *buf, size_t count)
-{
-        snprintf(dev->name, sizeof(dev->name), "%.*s",
-                 (int)min(count, sizeof(dev->name) - 1), buf);
-	return count;
-}
+    static ssize_t store_name(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+    {
+	    snprintf(dev->name, sizeof(dev->name), "%.*s",
+		    (int)min(count, sizeof(dev->name) - 1), buf);
+	    return count;
+    }
 
-static DEVICE_ATTR(name, S_IRUGO, show_name, store_name);
+    static DEVICE_ATTR(name, S_IRUGO, show_name, store_name);
 
 
-(Note that the real implementation doesn't allow userspace to set the 
+(Note that the real implementation doesn't allow userspace to set the
 name for a device.)
 
 
@@ -278,25 +288,25 @@ Top Level Directory Layout
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The sysfs directory arrangement exposes the relationship of kernel
-data structures. 
+data structures.
 
-The top level sysfs directory looks like:
+The top level sysfs directory looks like::
 
-block/
-bus/
-class/
-dev/
-devices/
-firmware/
-net/
-fs/
+    block/
+    bus/
+    class/
+    dev/
+    devices/
+    firmware/
+    net/
+    fs/
 
 devices/ contains a filesystem representation of the device tree. It maps
 directly to the internal kernel device tree, which is a hierarchy of
-struct device. 
+struct device.
 
 bus/ contains flat directory layout of the various bus types in the
-kernel. Each bus's directory contains two subdirectories:
+kernel. Each bus's directory contains two subdirectories::
 
 	devices/
 	drivers/
@@ -331,71 +341,71 @@ Current Interfaces
 The following interface layers currently exist in sysfs:
 
 
-- devices (include/linux/device.h)
-----------------------------------
-Structure:
+devices (include/linux/device.h)
+--------------------------------
+Structure::
 
-struct device_attribute {
-	struct attribute	attr;
-	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
-			char *buf);
-	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count);
-};
+    struct device_attribute {
+	    struct attribute	attr;
+	    ssize_t (*show)(struct device *dev, struct device_attribute *attr,
+			    char *buf);
+	    ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count);
+    };
 
-Declaring:
+Declaring::
 
-DEVICE_ATTR(_name, _mode, _show, _store);
+    DEVICE_ATTR(_name, _mode, _show, _store);
 
-Creation/Removal:
+Creation/Removal::
 
-int device_create_file(struct device *dev, const struct device_attribute * attr);
-void device_remove_file(struct device *dev, const struct device_attribute * attr);
+    int device_create_file(struct device *dev, const struct device_attribute * attr);
+    void device_remove_file(struct device *dev, const struct device_attribute * attr);
 
 
-- bus drivers (include/linux/device.h)
---------------------------------------
-Structure:
+bus drivers (include/linux/device.h)
+------------------------------------
+Structure::
 
-struct bus_attribute {
-        struct attribute        attr;
-        ssize_t (*show)(struct bus_type *, char * buf);
-        ssize_t (*store)(struct bus_type *, const char * buf, size_t count);
-};
+    struct bus_attribute {
+	    struct attribute        attr;
+	    ssize_t (*show)(struct bus_type *, char * buf);
+	    ssize_t (*store)(struct bus_type *, const char * buf, size_t count);
+    };
 
-Declaring:
+Declaring::
 
-static BUS_ATTR_RW(name);
-static BUS_ATTR_RO(name);
-static BUS_ATTR_WO(name);
+    static BUS_ATTR_RW(name);
+    static BUS_ATTR_RO(name);
+    static BUS_ATTR_WO(name);
 
-Creation/Removal:
+Creation/Removal::
 
-int bus_create_file(struct bus_type *, struct bus_attribute *);
-void bus_remove_file(struct bus_type *, struct bus_attribute *);
+    int bus_create_file(struct bus_type *, struct bus_attribute *);
+    void bus_remove_file(struct bus_type *, struct bus_attribute *);
 
 
-- device drivers (include/linux/device.h)
------------------------------------------
+device drivers (include/linux/device.h)
+---------------------------------------
 
-Structure:
+Structure::
 
-struct driver_attribute {
-        struct attribute        attr;
-        ssize_t (*show)(struct device_driver *, char * buf);
-        ssize_t (*store)(struct device_driver *, const char * buf,
-                         size_t count);
-};
+    struct driver_attribute {
+	    struct attribute        attr;
+	    ssize_t (*show)(struct device_driver *, char * buf);
+	    ssize_t (*store)(struct device_driver *, const char * buf,
+			    size_t count);
+    };
 
-Declaring:
+Declaring::
 
-DRIVER_ATTR_RO(_name)
-DRIVER_ATTR_RW(_name)
+    DRIVER_ATTR_RO(_name)
+    DRIVER_ATTR_RW(_name)
 
-Creation/Removal:
+Creation/Removal::
 
-int driver_create_file(struct device_driver *, const struct driver_attribute *);
-void driver_remove_file(struct device_driver *, const struct driver_attribute *);
+    int driver_create_file(struct device_driver *, const struct driver_attribute *);
+    void driver_remove_file(struct device_driver *, const struct driver_attribute *);
 
 
 Documentation
-- 
2.24.1

