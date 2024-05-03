Return-Path: <linux-fsdevel+bounces-18646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0988BAE98
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 16:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5A81F217D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B27154BF8;
	Fri,  3 May 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URrzFEig"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8857C84;
	Fri,  3 May 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745437; cv=none; b=qwPb76CvId+ph53XwNe+wDzS6dl7b3yQdkTI0YGmJWnux4rJoPDtrvId1opLFvOjuSS5ivl8iYxyGdmVi7Ff5H0DR3K1MMYw4XNkKACs8s1L7zNnDvcREbxMJdMdppmnySrSIdcnSEHSKU5nFYbkSh7klXF9TemEOt/9abcPbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745437; c=relaxed/simple;
	bh=xrkPnr6M2fqqjyNqVJXriL7Kgs//GJeo6hKRlFFCj2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J99IfAnFDYB0KSkOfMftqnsVoaDqzHFBSni4GlRW0q3LvmuktcZjFGM9sb/rZ9x0SfY2hxxkNtFbYOUuU6z9Z8nEyGHLJ1vrIFszoAb7xn7L1PG1IeM/tbaiJku567PRT+sHaRBRvGAJkFc9KFTZxfqyaGGDyL2vB7awxT12qmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URrzFEig; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so8006696b3a.0;
        Fri, 03 May 2024 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714745433; x=1715350233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oC7NrlSFTxzEfGtJOryUeXYXwbNnyIitzb4rNtOwuA4=;
        b=URrzFEigLr2m2VYY+Bg7mtQCFxqH9bD2eQO4TtoyMDBi5KjATltBgaV4AeNoWGBvCa
         do9a5jGV84/spqcwfpREETZoGj0snnXaaqusxY3E7MtyLQwQKhqG0soICXvjs9Yrc9Xw
         8hU0DLbhJeHJxQIUKHuG+z03xVFN31NJZBZCjNxDEXtsEt/N0Ajl6S30cHG/JRW7NMCM
         syIKoG3chX/8TBeDgpE6DS8IHWdqgIcEeQcXbrIHoO0RYbBB9FYKBUjsxhuF/6jL4OeQ
         gfkxBPk7UyGRWjxtaDZygx7FUo6K/Py4d7dF2vXuFVv2S7QbluNNWKMaQLfdn/X1pqq9
         15rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714745433; x=1715350233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oC7NrlSFTxzEfGtJOryUeXYXwbNnyIitzb4rNtOwuA4=;
        b=siKc04RqU29GXsnunuAOap/E3lqqCAJPVV16n3L61DknS6UsVRxM1Hlx53c8pPTaFN
         wMnKI/9PaC+HH4shB1TEfciN0grQSNgFTCMakhCmrv87bGZVYxvEnL2ZeAZMM2VjBSns
         RmPRbfmPZMd3xpkdI2OdSd/ACZ7XbHlXY7D2v3UzjoVcNBhaj54A6d91ISE1/YI5wpei
         j8L+SNTj4lLVJh/dr4qwBMSIZth/YM89fyYjEai4gDjvY2CeOEfYiGKtnbBBdwOnM7ls
         0hmnVVtLINvnqADjqzmvP2TeXmOIDG8xHl5HDil4OMUheUc8M6gcnDOT4dxJsvtPFSiV
         ccbw==
X-Forwarded-Encrypted: i=1; AJvYcCXxGW5kn08sTXSyJPRRq4yHjcsmN9jyKqdf8m55yY+SFoMKgaahsQu/ZjGd1Dhosjl9TMuaFUgzIb0RiipilgtFmVDVdRTmiTVF
X-Gm-Message-State: AOJu0YxGcxfvlHuhikf0/3A+K9n4ka1mwKAWIBB9Tib5Klt25NB5CAEo
	Chv2tywBN/FDzrIXr7xhcUrFvwDryoN1VcPRMyc0JQXrKfnWgxI2OldOCQ==
X-Google-Smtp-Source: AGHT+IHHJtsoaeT27cxG9e+WvigTzN/BBuUGZCOAHPLj5kRZFwvfoZyfWBdgz30OnGnEey4HoRBj5Q==
X-Received: by 2002:a05:6a00:4b42:b0:6ed:21bc:ed8c with SMTP id kr2-20020a056a004b4200b006ed21bced8cmr2525952pfb.18.1714745433122;
        Fri, 03 May 2024 07:10:33 -0700 (PDT)
Received: from dw-tp.. ([171.76.87.126])
        by smtp.gmail.com with ESMTPSA id u40-20020a056a0009a800b006ed98adec98sm3088580pfg.76.2024.05.03.07.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 07:10:32 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC] Documentation: Add initial iomap document
Date: Fri,  3 May 2024 19:40:19 +0530
Message-ID: <17e84cbae600898269e9ad35046ce6dc929036ae.1714744795.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This adds an initial first draft of iomap documentation. Hopefully this
will come useful to those who are looking for converting their
filesystems to iomap. Currently this is in text format since this is the
first draft. I would prefer to work on it's conversion to .rst once we
receive the feedback/review comments on the overall content of the document.
But feel free to let me know if we prefer it otherwise.

A lot of this has been collected from various email conversations, code
comments, commit messages and/or my own understanding of iomap. Please
note a large part of this has been taken from Dave's reply to last iomap
doc patchset. Thanks to Dave, Darrick, Matthew, Christoph and other iomap
developers who have taken time to explain the iomap design in various emails,
commits, comments etc.

Please note that this is not the complete iomap design doc. but a brief
overview of iomap.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 Documentation/filesystems/index.rst |   1 +
 Documentation/filesystems/iomap.txt | 289 ++++++++++++++++++++++++++++
 MAINTAINERS                         |   1 +
 3 files changed, 291 insertions(+)
 create mode 100644 Documentation/filesystems/iomap.txt

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 1f9b4c905a6a..c17b5a2ec29b 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -34,6 +34,7 @@ algorithms work.
    seq_file
    sharedsubtree
    idmappings
+   iomap

    automount-support

diff --git a/Documentation/filesystems/iomap.txt b/Documentation/filesystems/iomap.txt
new file mode 100644
index 000000000000..4f766b129975
--- /dev/null
+++ b/Documentation/filesystems/iomap.txt
@@ -0,0 +1,289 @@
+Introduction
+============
+iomap is a filesystem centric mapping layer that maps file's logical offset
+ranges to physical extents. It provides several iterator APIs which filesystems
+can use for doing various file_operations, address_space_operations,
+vm_operations, inode_operations etc. It supports APIs for doing direct-io,
+buffered-io, lseek, dax-io, page-mkwrite, swap_activate and extent reporting
+via fiemap.
+
+iomap is termed above as filesystem centric because it first calls
+->iomap_begin() phase supplied by the filesystem to get a mapped extent and
+then loops over each folio within that mapped extent.
+This is useful for filesystems because now they can allocate/reserve a much
+larger extent at begin phase v/s the older approach of doing block allocation
+of one block at a time by calling filesystem's provided ->get_blocks() routine.
+
+i.e. at a high level how iomap does write iter is [1]::
+	user IO
+	  loop for file IO range
+	    loop for each mapped extent
+	      if (buffered) {
+		loop for each page/folio {
+		  instantiate page cache
+		  copy data to/from page cache
+		  update page cache state
+		}
+	      } else { /* direct IO */
+		loop for each bio {
+		  pack user pages into bio
+		  submit bio
+		}
+	      }
+	    }
+	  }
+
+
+Motivation for filesystems to convert to iomap
+===============================================
+1. iomap is a modern filesystem mapping layer VFS abstraction.
+2. It also supports large folios for buffered-writes. Large folios can help
+improve filesystem buffered-write performance and can also improve overall
+system performance.
+3. Less maintenance overhead for individual filesystem maintainers.
+iomap is able to abstract away common folio-cache related operations from the
+filesystem to within the iomap layer itself. e.g. allocating, instantiating,
+locking and unlocking of the folios for buffered-write operations are now taken
+care within iomap. No ->write_begin(), ->write_end() or direct_IO
+address_space_operations are required to be implemented by filesystem using
+iomap.
+
+
+blocksize < pagesize path/large folios
+======================================
+Large folio support or systems with large pagesize e.g 64K on Power/ARM64 and
+4k blocksize, needs filesystems to support bs < ps paths. iomap embeds
+struct iomap_folio_state (ifs) within folio->private. ifs maintains uptodate
+and dirty bits for each subblock within the folio. Using ifs iomap can track
+update and dirty status of each block within the folio. This helps in supporting
+bs < ps path for such systems with large pagesize or with large folios [2].
+
+
+struct iomap
+=============
+This structure defines a file mapping information of logical file offset range
+to a physical mapped extent on which an IO operation could be performed.
+An iomap reflects a single contiguous range of filesystem address space that
+either exists in memory or on a block device.
+1. The type field within iomap determines what type the range maps to e.g.
+IOMAP_HOLE, IOMAP_DELALLOC, IOMAP_UNWRITTEN etc.
+
+2. The flags field represent the state flags (e.g. IOMAP_F_*), most of which are
+set the by the filesystem during mapping time that indicates how iomap
+infrastructure should modify it's behaviour to do the right thing.
+
+3. private void pointer within iomap allows the filesystems to pass filesystem's
+private data from ->iomap_begin() to ->iomap_end() [3].
+(see include/linux/iomap.h for more details)
+
+
+iomap operations
+================
+iomap provides different iterator APIs for direct-io, buffered-io, lseek,
+dax-io, page-mkwrite, swap_activate and extent reporting via fiemap. It requires
+various struct operations to be prepared by filesystem and to be supplied to
+iomap iterator APIs either at the beginning of iomap api call or attaching it
+during the mapping callback time e.g iomap_folio_ops is attached to
+iomap->folio_ops during ->iomap_begin() call.
+
+Following provides various ops to be supplied by filesystems to iomap layer for
+doing different I/O types as discussed above.
+
+iomap_ops: IO interface specific operations
+==========
+The methods are designed to be used as pairs. The begin method creates the iomap
+and attaches all the necessary state and information which subsequent iomap
+methods & their callbacks might need. Once the iomap infrastructure has finished
+working on the iomap it will call the end method to allow the filesystem to tear
+down any unused space and/or structures it created for the specific iomap
+context.
+
+Almost all iomap iterator APIs require filesystems to define iomap_ops so that
+filesystems can be called into for providing logical to physical extent mapping,
+wherever required. This is required by the iomap iter apis used for the
+operations which are listed in the beginning of "iomap operations" section.
+  - iomap_begin: This either returns an existing mapping or reserve/allocates a
+    new mapping when called by iomap. pos and length are passed as function
+    arguments. Filesystem returns the new mapping information within struct
+    iomap which also gets passed as a function argument. Filesystems should
+    provide the type of this extent in iomap->type for e.g. IOMAP_HOLE,
+    IOMAP_UNWRITTEN and it should set the iomap->flags e.g. IOMAP_F_*
+    (see details in include/linux/iomap.h)
+
+    Note that iomap_begin() call has srcmap passed as another argument. This is
+    mainly used only during the begin phase for COW mappings to identify where
+    the reads are to be performed from. Filesystems needs to fill that mapping
+    information if iomap should read data for partially written blocks from a
+    different location than the write target [4].
+
+  - iomap_end: Commit and/or unreserve space which was previously allocated
+    using iomap_begin. During buffered-io, when a short writes occurs,
+    filesystem may need to remove the reserved space that was allocated
+    during ->iomap_begin. For filesystems that use delalloc allocation, we need
+    to punch out delalloc extents from the range that are not dirty in the page
+    cache. See comments in iomap_file_buffered_write_punch_delalloc() for more
+    info [5][6].
+
+iomap_dio_ops: Direct I/O operations structure for iomap.
+=============
+This gets passed with iomap_dio_rw(), so that iomap can call certain operations
+before submission or on completion of DIRECT_IO.
+  - end_io: Required after bio completion for e.g. for conversion of unwritten
+    extents.
+
+  - submit_io: This hook is required for e.g. by filesystems like btrfs who
+    would like to do things like data replication for fs-handled RAID.
+
+  - bio_set: This allows the filesystem to provide custom bio_set for allocating
+    direct I/O bios. This will allow the filesystem who uses ->submit_io hook to
+    stash away additional information for filesystem use. Filesystems will
+    provide their custom ->bi_end_io function completion which should then call
+    into iomap_dio_bio_end_io() for dio completion [11].
+
+iomap_writeback_ops: Writeback operations structure for iomap
+====================
+Writeback address space operations e.g. iomap_writepages(), requires the
+filesystem to pass this ops field.
+   - map_blocks: map the blocks at the writeback time. This is called once per
+     folio. Filesystems can return an existing mapping from a previous call if
+     that mapping is still valid. This can race with paths which can invalidate
+     previous mappings such as fallocate/truncate. Hence filesystems must have
+     a mechanism by which it can validate if the previous mapping provided is
+     still valid. Filesystems might need a per inode seq counter which can be
+     used to verify if the underlying mapping of logical to physical blocks
+     has changed since the last ->map_blocks call or not.
+     They can then use wpc->iomap->validity_cookie to cache their seq count in
+     ->map_blocks call [6].
+
+  - prepare_ioend: Allows filesystems to process the extents before submission
+    for e.g. convert COW extents to regular. This also allows filesystem to
+    hook in a custom completion handler for processing bio completion e.g.
+    conversion of unwritten extents.
+    Note that ioends might need to be processed as an atomic completion unit
+    (using transactions) when all the chained bios in the ioend have completed
+    (e.g. for conversion of unwritten extents). iomap provides some helper
+    methods for ioend merging and completion [12]. Look at comments in
+    xfs_end_io() routine for more info.
+
+  - discard_folio: In case if the filesystem has any delalloc blocks on it,
+    then those needs to be punched out in this call. Otherwise, it may leave a
+    stale delalloc mapping covered by a clean page that needs to be dirtied
+    again before the delalloc mapping can be converted. This stale delalloc
+    mapping can trip the direct I/O reads when done on the same region [7].
+
+iomap_folio_ops: Folio related operations structure for iomap.
+================
+When filesystem sets folio_ops in an iomap mapping it returns, ->get_folio()
+and ->put_folio() will be called for each folio written to during write iter
+time of buffered writes.
+  - get_folio: iomap will call ->get_folio() for every folio of the returned
+    iomap mapping. Currently gfs2 uses this to start the transaction before
+    taking the folio lock [8].
+
+  - put_folio: iomap will call ->put_folio() once the data has been written to
+    for each folio of the returned iomap mapping. GFS2 uses this to add data
+    bufs to the transaction before unlocking the folio and then ending the
+    transaction [9].
+
+  - iomap_valid: Filesystem internal extent map can change while iomap is
+    iterating each folio of a cached iomap, so this hook allows iomap to detect
+    that the iomap needs to be refreshed during a long running write operation.
+    Filesystems can store an internal state (e.g. a sequence no.) in
+    iomap->validity_cookie when the iomap is first mapped, to be able to detect
+    changes between the mapping time and whenever iomap calls ->iomap_valid().
+    This gets called with the locked folio. See iomap_write_begin() for more
+    comments around ->iomap_valid() [10].
+
+
+Locking
+========
+iomap assumes two layers of locking. It requires locking above the iomap layer
+for IO serialisation (i_rwsem, invalidation lock) which is generally taken
+before calling into iomap iter functions. There is also locking below iomap for
+mapping/allocation serialisation on an inode (e.g. XFS_ILOCK or i_data_sem in
+ext4 etc) that is usually taken inside the mapping methods which filesystems
+supplied to the iomap infrastructure. This layer of locking needs to be
+independent of the IO path serialisation locking as it nests inside in the IO
+path but is also used without the filesystem IO path locking protecting it
+(e.g. in the iomap writeback path).
+
+General Locking order in iomap is:
+inode->i_rwsem (shared or exclusive)
+  inode->i_mapping->invalidate_lock (exclusive)
+    folio_lock()
+	internal filesystem allocation lock (e.g. XFS_ILOCK or i_data_sem)
+
+
+Zeroing/Truncate Operations
+===========================
+Filesystems can use iomap provided helper functions e.g. iomap_zero_range(),
+iomap_truncate_page() & iomap_file_unshare() for various truncate/fallocate or
+any other similar operations that requires zeroing/truncate.
+See above functions for more details on how these can be used by individual
+filesystems.
+
+
+Guideline for filesystem conversion to iomap
+=============================================
+The right approach is to first implement ->iomap_begin and (if necessary)
+->iomap_end to allow iomap to obtain a read-only mapping of a file range.  In
+most cases, this is a relatively trivial conversion of the existing get_block()
+callback for read-only mappings.
+
+i.e. rewrite the filesystem's get_block(create = false) implementation to use
+the new ->iomap_begin() implementation. i.e. get_block wraps around the outside
+and converts the information from bufferhead-based map to what iomap expects.
+This will convert all the existing read-only mapping users to use the new iomap
+mapping function internally. This way the iomap mapping function can be further
+tested without needing to implement any other iomap APIs.
+
+FIEMAP operation is a really good first target because it is trivial to
+implement support for it and then to determine that the extent map iteration is
+correct from userspace. i.e. if FIEMAP is returning the correct information,
+it's a good sign that other read-only mapping operations will also do the right
+thing.
+
+Once everything is working like this, then convert all the other read-only
+mapping operations to use iomap. Done one at a time, regressions should be self
+evident. The only likely complexity at this point will be the buffered read IO
+path because of bufferheads. The buffered read IO paths doesn't need to be
+converted yet, though the direct IO read path should be converted in this phase.
+
+The next thing to do is implement get_blocks(create = true) functionality in the
+->iomap_begin/end() methods. Then convert the direct IO write path to iomap, and
+start running fsx w/ DIO enabled in earnest on filesystem. This will flush out
+lots of data integrity corner case bug that the new write mapping implementation
+introduces.
+
+(TODO - get more info on this from Dave): At this point, converting the entire
+get_blocks() path to call the iomap functions and convert the iomaps to
+bufferhead maps is possible. This will get the entire filesystem using the new
+mapping functions, and they should largely be debugged and working correctly
+after this step.
+
+This now largely leaves the buffered read and write paths to be converted. The
+mapping functions should all work correctly, so all that needs to be done is
+rewriting all the code that interfaces with bufferheads to interface with iomap
+and folios. It is rather easier first to get regular file I/O (without any
+fancy feature like fscrypt, fsverity, data=journaling) converted to use iomap
+and then work on directory handling conversion to iomap.
+
+The rest is left as an exercise for the reader, as it will be different for
+every filesystem.
+
+References:
+===========
+[1]: https://lore.kernel.org/all/ZGbVaewzcCysclPt@dread.disaster.area/
+[2]: https://lore.kernel.org/all/20230725122932.144426-1-ritesh.list@gmail.com/
+[3]: https://lore.kernel.org/all/20180619164137.13720-7-hch@lst.de/
+[4]: https://lore.kernel.org/all/20191008071527.29304-9-hch@lst.de/
+[5]: https://lore.kernel.org/all/20221123055812.747923-6-david@fromorbit.com/
+[6]: https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/
+[7]: https://lore.kernel.org/all/20201029163313.1766967-1-bfoster@redhat.com/
+[8]: https://lore.kernel.org/all/20190429220934.10415-5-agruenba@redhat.com/
+[9]: https://lore.kernel.org/all/20180619164137.13720-6-hch@lst.de/
+[10]: https://lore.kernel.org/all/20221123055812.747923-8-david@fromorbit.com/
+[11]: https://lore.kernel.org/all/20220505201115.937837-3-hch@lst.de/
+[12]: https://lore.kernel.org/all/20220120034733.221737-1-david@fromorbit.com/
+[13]: LWN article on iomap https://lwn.net/Articles/935934/
+[14]: Kernel newbies page on iomap https://kernelnewbies.org/KernelProjects/iomap
diff --git a/MAINTAINERS b/MAINTAINERS
index ebf03f5f0619..41e739a94927 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8302,6 +8302,7 @@ R:	Darrick J. Wong <djwong@kernel.org>
 L:	linux-xfs@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
+F:	Documentation/filesystems/iomap.txt
 F:	fs/iomap/
 F:	include/linux/iomap.h

--
2.44.0


