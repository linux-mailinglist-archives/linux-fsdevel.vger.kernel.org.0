Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC9D1238B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 22:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfEBUls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 16:41:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59220 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBUls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 16:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mZQoNwnK1Ap2srLPfaYfs07Mlrg3Nsogmm7NfDWy+k8=; b=HbCv6yx4+WlH7vmiqebO3y83yj
        dNu4D20tqVNdFLoPSibvpSIy32QtWlovmcwLKly5NLHOoqQLMqqY1y9Ku9hqs+jS+up0RyXlo0rgV
        Wfkh5FdgpRK3FG4zcQsppuyo3H5yVHw4OLu5CVIQgN3KyKYBuHA13mcyxgtl/Ux1FkO07pM7u1amW
        +5EhBf+0p1XoPGg9zbFA1ijGImfX2ge4TZMljwaqiXdwYpkl7MejgNfMp94JMitTHBwjlnN9NZQ6v
        fGmLVXTUdRxTcsHJMP0R6p/ggwVAay2EgoTck/dZhVQsbQaaXUeAd3/pI7IOHJ0Djy3Ti876cnMWZ
        2Ql1HUGA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMIWW-0003nt-BL; Thu, 02 May 2019 20:41:44 +0000
Subject: Re: [PATCH 1/6] incfs: Add first files of incrementalfs
To:     ezemtsov@google.com, linux-fsdevel@vger.kernel.org
Cc:     tytso@mit.edu
References: <20190502040331.81196-1-ezemtsov@google.com>
 <20190502040331.81196-2-ezemtsov@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e36f89ef-2060-9cb6-2b3f-0b246c9208d2@infradead.org>
Date:   Thu, 2 May 2019 13:41:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502040331.81196-2-ezemtsov@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/19 9:03 PM, ezemtsov@google.com wrote:
> From: Eugene Zemtsov <ezemtsov@google.com>
> 
> - fs/incfs dir
> - Kconfig (CONFIG_INCREMENTAL_FS)
> - Makefile
> - Module and file system initialization and clean up code
> - New MAINTAINERS entry
> - Add incrementalfs.h UAPI header
> - Register ioctl range in ioctl-numbers.txt
> - Documentation
> 
> Signed-off-by: Eugene Zemtsov <ezemtsov@google.com>

Hi,
This is just Documentation comments...

> ---
>  Documentation/filesystems/incrementalfs.rst | 452 ++++++++++++++++++++
>  Documentation/ioctl/ioctl-number.txt        |   1 +
>  MAINTAINERS                                 |   7 +
>  fs/Kconfig                                  |   1 +
>  fs/Makefile                                 |   1 +
>  fs/incfs/Kconfig                            |  10 +
>  fs/incfs/Makefile                           |   4 +
>  fs/incfs/main.c                             |  85 ++++
>  fs/incfs/vfs.c                              |  37 ++
>  include/uapi/linux/incrementalfs.h          | 189 ++++++++
>  10 files changed, 787 insertions(+)
>  create mode 100644 Documentation/filesystems/incrementalfs.rst
>  create mode 100644 fs/incfs/Kconfig
>  create mode 100644 fs/incfs/Makefile
>  create mode 100644 fs/incfs/main.c
>  create mode 100644 fs/incfs/vfs.c
>  create mode 100644 include/uapi/linux/incrementalfs.h
> 
> diff --git a/Documentation/filesystems/incrementalfs.rst b/Documentation/filesystems/incrementalfs.rst
> new file mode 100644
> index 000000000000..682e3dcb6b5a
> --- /dev/null
> +++ b/Documentation/filesystems/incrementalfs.rst
> @@ -0,0 +1,452 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +Incremental File System
> +=======================
> +
> +Overview
> +========
> +Incremental FS is special-purpose Linux virtual file system that allows
> +execution of a program while its binary and resource files are still being
> +lazily downloaded over the network, USB etc. It is focused on incremental
> +delivery for a small number (under 100) of big files (more than 10 megabytes).
> +Incremental FS doesn’t allow direct writes into files and, once loaded, file
> +content never changes. Incremental FS doesn’t use a block device, instead it
> +saves data into a backing file located on a regular file-system.
> +
> +But why?
> +--------
> +To allow running **big** Android apps before their binaries and resources are
> +fully downloaded to an Android device. If an app reads something not loaded yet,
> +it needs to wait for the data block to be fetched, but in most cases hot blocks
> +can be loaded in advance.
> +
> +Workflow
> +--------
> +A userspace process, called a data loader, mounts an instance of incremental-fs
> +giving it a file descriptor on an underlying file system (like ext4 or f2fs).
> +Incremental-fs reads content (if any) of this backing file and interprets it as
> +a file system image with files, directories and data blocks. At this point
> +the data loader can declare new files to be shown by incremental-fs.
> +
> +A process is started from a binary located on incremental-fs.
> +All reads are served directly from the backing file
> +without roundtrips into userspace. If the process accesses a data block that was
> +not originally present in the backing file, the read operation waits.
> +
> +Meanwhile the data loader can feed new data blocks to incremental-fs by calling
> +write() on a special .cmd pseudo-file. The data loader can request information
> +about pending reads by calling poll() and read() on the .cmd pseudo-file.
> +This mechanism allows the data loader to serve most urgently needed data first.
> +Once a data block is given to incremental-fs, it saves it to the backing file
> +and unblocks all the reads waiting for this block.
> +
> +Eventually all data for all files is uploaded by the data loader, and saved by
> +incremental-fs into the backing file. At that moment the data loader is not
> +needed any longer. The backing file will play the role of a complete
> +filesystem image for all future runs of the program.
> +
> +Non-goals
> +---------
> +* Allowing direct writes by the executing processes into files on incremental-fs
> +* Allowing the data loader change file size or content after it was loaded.
> +* Having more than a couple hundred files and directories.
> +
> +
> +Features
> +========
> +
> +Read-only, but not unchanging
> +-----------------------------
> +On the surface a mount directory of incremental-fs would look similar to
> +a read-only instance of network file system: files and directories can be
> +listed and read, but can’t be directly created or modified via creat() or
> +write(). At the same time the data loader can make changes to a directory
> +structure via external ioctl-s. i.e. link and unlink files and directories
> +(if they empty). Data can't be changed this way, once a file block is loaded

                                               way; once

> +there is no way to change it.
> +
> +Filesystem image in a backing file
> +----------------------------------
> +Instead of using a block device, all data and metadata is stored in a

                                                          are stored

> +backing file provided as a mount parameter. The backing file is located on
> +an underlying file system (like ext4 or f2fs). Such approach is very similar
> +to what might be achieved by using loopback device with a traditional file
> +system, but it avoids extra set-up steps and indirections. It also allows
> +incremental-fs image to dynamically grow as new files and data come without
> +having to do any extra steps for resizing.
> +
> +If the backing file contains data at the moment when incremental-fs is mounted,
> +content of the backing file is being interpreted as filesystem image.

                          file is interpreted as

> +New files and data can still be added through the external interface,
> +and they will be saved to the backing file.
> +
> +Data compression
> +----------------
> +Incremental-fs can store compressed data. In this case each 4KB data block is
> +compressed separately. Data blocks can be provided to incremental-fs by
> +the data loader in a compressed form. Incremental-fs uncompresses blocks
> +each time a executing process reads it (modulo page cache). Compression also

             an executing process

> +takes care of blocks composed of all zero bytes removing necessity to handle
> +this case separately.
> +
> +Partially present files
> +-----------------------
> +Data in the files consists of 4KB blocks, each block can be present or absent.

                                     blocks; each block

> +Unlike in sparse files, reading an absent block doesn’t return all zeros.
> +It waits for the data block to be loaded via the ioctl interface
> +(respecting a timeout). Once a data block is loaded it never disappears
> +and can’t be changed or erased from a file. This ability to frictionlessly
> +wait for temporary missing data is the main feature of incremental-fs.
> +
> +Hard links. Multiple names for the same file
> +--------------------------------------------
> +Like all traditional UNIX file systems, incremental-fs supports hard links,
> +i.e. different file names in different directories can refer to the same file.
> +As mentioned above new hard links can be created and removed via
> +the ioctl interface, but actual data files are immutable, modulo partial
> +data loading. Each directory can only have at most one name referencing it.
> +
> +Inspection of incremental-fs internal state
> +-------------------------------------------
> +poll() and read() on the .cmd pseudo-file allow data loaders to get a list of
> +read operations stalled due to lack of a data block (pending reads).
> +
> +
> +Application Programming Interface
> +=================================
> +
> +Regular file system interface
> +-----------------------------
> +Executing process access files and directories via regular Linux file interface:

                     accesses

> +open, read, close etc. All the intricacies of data loading a file representation
> +are hidden from them.
> +
> +External .cmd file interface
> +----------------------------
> +When incremental-fs is mounted, a mount directory contains a pseudo-file
> +called '.cmd'. The data loader will open this file and call read(), write(),
> +poll() and ioctl() on it inspect and change state of incremental-fs.
> +
> +poll() and read() are used by the data loader to wait for pending reads to
> +appear and obtain an array of ``struct incfs_pending_read_info``.
> +
> +write() is used by the data loader to feed new data blocks to incremental-fs.
> +A data buffer given to write() is interpreted as an array of
> +``struct incfs_new_data_block``. Structs in the array describe locations and
> +properties of data blocks loaded with this write() call.
> +
> +``ioctl(INCFS_IOC_PROCESS_INSTRUCTION)`` is used to change structure of
> +incremental-fs. It receives an pointer to ``struct incfs_instruction``

                               a pointer

> +where type field can have be one of the following values.
> +
> +**INCFS_INSTRUCTION_NEW_FILE**
> +Creates an inode (a file or a directory) without a name.
> +It assumes ``incfs_new_file_instruction.file`` is populated with details.
> +
> +**INCFS_INSTRUCTION_ADD_DIR_ENTRY**
> +Creates a name (aka hardlink) for an inode in a directory.
> +A directory can't have more than one hardlink pointing to it, but files can be
> +linked from different directories.
> +It assumes ``incfs_new_file_instruction.dir_entry`` is populated with details.
> +
> +**INCFS_INSTRUCTION_REMOVE_DIR_ENTRY**
> +Remove a name (aka hardlink) for a file from a directory.
> +Only empty directories can be unlinked.
> +It assumes ``incfs_new_file_instruction.dir_entry`` is populated with details.
> +
> +For more details see in uapi/linux/incrementalfs.h and samples below.
> +
> +Supported mount options
> +-----------------------
> +See ``fs/incfs/options.c`` for more details.
> +
> +    * ``backing_fd=<unsigned int>``
> +        Required. A file descriptor of a backing file opened by the process
> +        calling mount(2). This descriptor can be closed after mount returns.
> +
> +    * ``read_timeout_msc=<unsigned int>``
> +        Default: 1000. Timeout in milliseconds before a read operation fails
> +        if no data found in the backing file or provided by the data loader.
> +
> +Sysfs files
> +-----------
> +``/sys/fs/incremental-fs/version`` - a current version of the filesystem.
> +One ASCII encoded positive integer number with a new line at the end.
> +
> +
> +Examples
> +--------
> +See ``sample_data_loader.c`` for a complete implementation of a data loader.
> +
> +Mount incremental-fs
> +~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +    int mount_fs(char *mount_dir, char *backing_file, int timeout_msc)
> +    {
> +        static const char fs_name[] = INCFS_NAME;
> +        char mount_options[512];
> +        int backing_fd;
> +        int result;
> +
> +        backing_fd = open(backing_file, O_RDWR);
> +        if (backing_fd == -1) {
> +            perror("Error in opening backing file");
> +            return 1;
> +        }
> +
> +        snprintf(mount_options, ARRAY_SIZE(mount_options),
> +            "backing_fd=%u,read_timeout_msc=%u", backing_fd, timeout_msc);
> +
> +        result = mount(fs_name, mount_dir, fs_name, 0, mount_options);
> +        if (result != 0)
> +            perror("Error mounting fs.");
> +        return result;
> +    }
> +
> +Open .cmd file
> +~~~~~~~~~~~~~~
> +
> +::
> +
> +    int open_commands_file(char *mount_dir)
> +    {
> +        char cmd_file[255];
> +        int cmd_fd;
> +
> +        snprintf(cmd_file, ARRAY_SIZE(cmd_file), "%s/.cmd", mount_dir);
> +        cmd_fd = open(cmd_file, O_RDWR);
> +        if (cmd_fd < 0)
> +            perror("Can't open commands file");
> +        return cmd_fd;
> +    }
> +
> +Add a file to the file system
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +    int create_file(int cmd_fd, char *filename, int *ino_out, size_t size)
> +    {
> +        int ret = 0;
> +        __u16 ino = 0;
> +        struct incfs_instruction inst = {
> +                .version = INCFS_HEADER_VER,
> +                .type = INCFS_INSTRUCTION_NEW_FILE,
> +                .file = {
> +                    .size = size,
> +                    .mode = S_IFREG | 0555,
> +                }
> +        };
> +
> +        ret = ioctl(cmd_fd, INCFS_IOC_PROCESS_INSTRUCTION, &inst);
> +        if (ret)
> +            return -errno;
> +
> +        ino = inst.file.ino_out;
> +        inst = (struct incfs_instruction){
> +                .version = INCFS_HEADER_VER,
> +                .type = INCFS_INSTRUCTION_ADD_DIR_ENTRY,
> +                .dir_entry = {
> +                    .dir_ino = INCFS_ROOT_INODE,
> +                    .child_ino = ino,
> +                    .name = ptr_to_u64(filename),
> +                    .name_len = strlen(filename)
> +                }
> +            };
> +        ret = ioctl(cmd_fd, INCFS_IOC_PROCESS_INSTRUCTION, &inst);
> +        if (ret)
> +            return -errno;
> +        *ino_out = ino;
> +        return 0;
> +    }
> +
> +Load data into a file
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +    int cmd_fd = open_commands_file(path_to_mount_dir);
> +    char *data = get_some_data();
> +    struct incfs_new_data_block block;
> +    int err;
> +
> +    block.file_ino = file_ino;
> +    block.block_index = 0;
> +    block.compression = COMPRESSION_NONE;
> +    block.data = (__u64)data;
> +    block.data_len = INCFS_DATA_FILE_BLOCK_SIZE;
> +
> +    err = write(cmd_fd, &block, sizeof(block));
> +
> +
> +Get an array of pending reads
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +    int poll_res = 0;
> +    struct incfs_pending_read_info reads[10];
> +    int cmd_fd = open_commands_file(path_to_mount_dir);
> +    struct pollfd pollfd = {
> +        .fd = cmd_fd,
> +        .events = POLLIN
> +    };
> +
> +    poll_res = poll(&pollfd, 1, timeout);
> +    if (poll_res > 0 && (pollfd.revents | POLLIN)) {
> +        ssize_t read_res = read(cmd_fd, reads, sizeof(reads));
> +        if (read_res > 0)
> +            printf("Waiting reads %ld\n", read_res / sizeof(reads[0]));
> +    }
> +
> +
> +
> +Ondisk format
> +=============
> +
> +General principles
> +------------------
> +* The backbone of the incremental-fs ondisk format is an append only linked
> +  list of metadata blocks. Each metadata block contains an offset of the next
> +  one. These blocks describe files and directories on the
> +  file system. They also represent actions of adding and removing file names
> +  (hard links).
> +  Every time incremental-fs instance is mounted, it reads through this list
> +  to recreate filesystem's state in memory. An offset of the first record in the
> +  metadata list is stored in the superblock at the beginning of the backing
> +  file.
> +
> +* Most of the backing file is taken by data areas and blockmaps.
> +  Since data blocks can be compressed and have different sizes,
> +  single per-file data area can't be pre-allocated. That's why blockmaps are
> +  needed in order to find a location and size of each data block in
> +  the backing file. Each time a file is created, a corresponding block map is
> +  allocated to store future offsets of data blocks.
> +
> +  Whenever a data block is given by data loader to incremental-fs:
> +    - A data area with the given block is appended to the end of
> +      the backing file.
> +    - A record in the blockmap for the given block index is updated to reflect
> +      its location, size, and compression algorithm.
> +
> +Important format details
> +------------------------
> +Ondisk structures are defined in the ``format.h`` file. They are all packed
> +and use little-endian order.
> +A backing file must start with ``incfs_super_block`` with ``s_magic`` field
> +equal to 0x5346434e49 "INCFS".
> +
> +Metadata records:
> +
> +* ``incfs_inode`` - metadata record to declare a file or a directory.
> +                    ``incfs_inode.i_mode`` determents if it is a file

                                              determines

> +                    or a directory.
> +* ``incfs_blockmap_entry`` - metadata record that specifies size and location
> +                            of a blockmap area for a given file. This area
> +                            contains an array of ``incfs_blockmap_entry``-s.
> +* ``incfs_dir_action`` - metadata record that specifies changes made to a
> +                    to a directory structure, e.g. add or remove a hardlink.
> +* ``incfs_md_header`` - header of a metadata record. It's always a part
> +                    of other structures and served purpose of metadata

?                                              serves

> +                    bookkeeping.
> +
> +Other ondisk structures:
> +
> +* ``incfs_super_block`` - backing file header
> +* ``incfs_blockmap_entry`` - a record in a blockmap area that describes size
> +                        and location of a data block.
> +* Data blocks dont have any particular structure, they are written to the backing

                 don't

> +  file in a raw form as they come from a data loader.
> +
> +
> +Backing file layout
> +-------------------
> +::
> +
> +              +-------------------------------------------+
> +              |            incfs_super_block              |]---+
> +              +-------------------------------------------+    |
> +              |                 metadata                  |<---+
> +              |                incfs_inode                |]---+
> +              +-------------------------------------------+    |
> +                        .........................              |
> +              +-------------------------------------------+    |   metadata
> +     +------->|               blockmap area               |    |  list links
> +     |        |          [incfs_blockmap_entry]           |    |
> +     |        |          [incfs_blockmap_entry]           |    |
> +     |        |          [incfs_blockmap_entry]           |    |
> +     |    +--[|          [incfs_blockmap_entry]           |    |
> +     |    |   |          [incfs_blockmap_entry]           |    |
> +     |    |   |          [incfs_blockmap_entry]           |    |
> +     |    |   +-------------------------------------------+    |
> +     |    |             .........................              |
> +     |    |   +-------------------------------------------+    |
> +     |    |   |                 metadata                  |<---+
> +     +----|--[|               incfs_blockmap              |]---+
> +          |   +-------------------------------------------+    |
> +          |             .........................              |
> +          |   +-------------------------------------------+    |
> +          +-->|                 data block                |    |
> +              +-------------------------------------------+    |
> +                        .........................              |
> +              +-------------------------------------------+    |
> +              |                 metadata                  |<---+
> +              |             incfs_dir_action              |
> +              +-------------------------------------------+
> +
> +Unreferenced files and absence of garbage collection
> +----------------------------------------------------
> +Described file format can produce files that don't have any names for them in
> +any directories. Incremental-fs takes no steps to prevent such situations or
> +reclaim space occupied by such files in the backing file. If garbage collection
> +is needed it has to be implemented as a separate userspace tool.
> +
> +
> +Design alternatives
> +===================
> +
> +Why isn't incremental-fs implemented via FUSE?
> +----------------------------------------------
> +TLDR: FUSE-based filesystems add 20-80% of performance overhead for target
> +scenarios, and increase power use on mobile beyond acceptable limit
> +for widespread deployment. A custom kernel filesystem is the way to overcome
> +these limitations.
> +
> +From the theoretical side of things, FUSE filesystem adds some overhead to
> +each filesystem operation that’s not handled by OS page cache:
> +
> +    * When an IO request arrives to FUSE driver (D), it puts it into a queue
> +      that runs on a separate kernel thread
> +    * Then another separate user-mode handler process (H) has to run,
> +      potentially after a context switch, to read the request from the queue.
> +      Reading the request adds a kernel-user mode transition to the handling.
> +    * (H) sends the IO request to kernel to handle it on some underlying storage
> +      filesystem. This adds a user-kernel and kernel-user mode transition
> +      pair to the handling.
> +    * (H) then responds to the FUSE request via a write(2) call.
> +      Writing the response is another user-kernel mode transition.
> +    * (D) needs to read the response from (H) when its kernel thread runs
> +      and forward it to the user
> +
> +Together, the scenario adds 2 extra user-kernel-user mode transition pairs,
> +and potentially has up to 3 additional context switches for the FUSE kernel
> +thread and the user-mode handler to start running for each IO request on the
> +filesystem.
> +This overhead can vary from unnoticeable to unmanageable, depending on the
> +target scenario. But it will always burn extra power via CPU staying longer
> +in non-idle state, handling context switches and mode transitions.
> +One important goal for the new filesystem is to be able to handle each page
> +read separately on demand, because we don't want to wait and download more data
> +than absolutely necessary. Thus readahead would need to be disabled completely.
> +This increases the number of separate IO requests and the FUSE related overhead
> +by almost 32x (128KB readahead limit vs 4KB individual block operations)
> +
> +For more info see a 2017 USENIX research paper:
> +To FUSE or Not to FUSE: Performance of User-Space File Systems
> +Bharath Kumar Reddy Vangoor, Stony Brook University;
> +Vasily Tarasov, IBM Research-Almaden;
> +Erez Zadok, Stony Brook University
> +https://www.usenix.org/system/files/conference/fast17/fast17-vangoor.pdf


-- 
~Randy
