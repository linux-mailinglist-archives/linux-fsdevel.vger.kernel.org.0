Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E2172EB34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 20:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbjFMSpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 14:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjFMSpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:45:01 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F9C1BDC
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 11:44:59 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so24205ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686681898; x=1689273898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkCb0yFxfR4opINNJsGvfT//mpUEjiOj45xzWBFj8VM=;
        b=Zby6oNorVmRoqwVF6+hjAJrFiNISC3tvVqx5OLJFMY3po6VG1xGebxomdPBOCbJ0gS
         c+2j61h66X4fgfZqNNEb3v+l0wdeW2fIH8XTKl5mCJrAXFGNC7L+Ziq0ousiTRgEDQYI
         nf53wPeH+XYEoE4YcnQ4s3rnhJHf+xMQBWSPDrMWFJwgUqYQmw8lHP8e2JoRp41b0qba
         wTgcgznq6Skj4GVzJxC2OdvIeSpCL6mJJ67xB8EASSbKJt5hNhoziN/loKMDFcUjoko4
         leuQjxmdQlXZsE8WF5DWFJEjWsYK00un35D6tLc34dgV1ogxS+SJF8PqM9d3nqMe/hHT
         EhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681898; x=1689273898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkCb0yFxfR4opINNJsGvfT//mpUEjiOj45xzWBFj8VM=;
        b=ShlhRcpOL5YniPDkp/jSoH2YVtWysqM0LJFhTYV9CUHrl+1XkuheKnTvADuF4+V11u
         erSGYduY8sd/22V63XVvIekJfZJtMXvFfDKvQKMCRjdgyvd5GmBUp8r2/8qxJi+UOEjq
         Ak2lRz9ynCHA05tL32Pw+qUczZeGJFNlplbQs6kj0yOhSsHUIROKhviL3Yb0tBiFHTm1
         4eLnUR4vepeS9TtS4ecSeF6Lkq6EpBNLXam0erKbYWpkMllKmmrK47AH5+UGrbEzHy4r
         qXKFY6T0I2ZtYvJeeLpbxbaQnDIdDUm55l5IPo5yruihUCtMTTSPFK7UdAf5PE5L9vTj
         c4bw==
X-Gm-Message-State: AC+VfDwtI44ENf/xotsoolplNt5dRLusEekQJT7JYwlW1XgZyRZV0Qb/
        Qx0Ai+kK1Vf0qtzE/f8d6LfIaA==
X-Google-Smtp-Source: ACHHUZ4JbDitzJjJ2Lghi72Mu72vEuviVacnx0bwQzYEBNyM6dNJ+ETPjetmQMYyiVyhpZB/h0gF3w==
X-Received: by 2002:a05:6e02:194c:b0:337:c28c:3d0f with SMTP id x12-20020a056e02194c00b00337c28c3d0fmr29219ilu.6.1686681898060;
        Tue, 13 Jun 2023 11:44:58 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:cb62:3c3c:921b:d84])
        by smtp.gmail.com with ESMTPSA id k11-20020a02cccb000000b004065707eb2bsm3610615jaq.42.2023.06.13.11.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 11:44:57 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:44:54 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/2] Report on physically contiguous memory in smaps
Message-ID: <ZIi5JnOOffcsoVL0@google.com>
References: <20230613160950.3554675-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613160950.3554675-1-ryan.roberts@arm.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 05:09:48PM +0100, Ryan Roberts wrote:
> Hi All,
> 
> I thought I would try my luck with this pair of patches...

Ack on the idea.

Actually I have a script to do just this, but it's based on pagemap (attaching the script at the end).

> This series adds new entries to /proc/pid/smaps[_rollup] to report on physically
> contiguous runs of memory. The first patch reports on the sizes of the runs by
> binning into power-of-2 blocks and reporting how much memory is in which bin.
> The second patch reports on how much of the memory is contpte-mapped in the page
> table (this is a hint that arm64 supports to tell the HW that a range of ptes
> map physically contiguous memory).
> 
> With filesystems now supporting large folios in the page cache, this provides a
> useful way to see what sizes are actually getting mapped. And with the prospect
> of large folios for anonymous memory and contpte mapping for conformant large
> folios on the horizon, this reporting will become useful to aid application
> performance optimization.
> 
> Perhaps I should really be submitting these patches as part of my large anon
> folios and contpte sets (which I plan to post soon), but given this touches
> the user ABI, I thought it was sensible to post it early and separately to get
> feedback.
> 
> It would specifically be good to get feedback on:
> 
>   - The exact set of new fields depend on the system that its being run on. Does
>     this cause problem for compat? (specifically the bins are determined based
>     on PAGE_SIZE and PMD_SIZE).
>   - The ContPTEMapped field is effectively arm64-specific. What is the preferred
>     way to handle arch-specific values if not here?

No strong opinions here.

===

$ cat memory-histogram/mem_hist.py
"""Script that scans VMAs, outputting histograms regarding memory allocations.

Example usage:
  python3 mem_hist.py --omit-file-backed --omit-unfaulted-vmas

For every process on the system, this script scans each VMA, counting the number
of order n allocations for 0 <= n <= MAX_ORDER. An order n allocation is a
region of memory aligned to a PAGESIZE * (2 ^ n) sized region consisting of 2 ^
n pages in which every page is present (according to the data in
/proc/<pid>/pagemap).  VMA information as in /proc/<pid>/maps is output for all
scanned VMAs along with a histogram of allocation orders. For example, this
histogram states that there are 12 order 0 allocations, 4 order 1 allocations, 5
order 2 allocations, and so on:

  [12, 4, 5, 9, 5, 10, 6, 2, 2, 4, 3, 4]

In addition to per-VMA histograms, per-process histograms are printed.
Per-process histograms are the sum of the histograms of all VMAs contained
within it, allowing for an overview of the memory allocations patterns of the
process as a whole.

Processes, and VMAs under each process are printed sorted in reverse-lexographic
order of historgrams. That is, VMAs containing more high order allocations will
be printed after ones containing more low order allocations. The output can thus
be easily visually scanned to find VMAs in which hugepage use shows the most
potential benefit.

To reduce output clutter, the options --omit-file-backed exists to omit VMAs
that are file backed (which, outside of tmpfs, don't support transparent
hugepages on Linux). Additionally, the option --omit-unfaulted-vmas exists to
omit VMAs containing zero resident pages.
"""
import argparse
import functools
import re
import struct
import subprocess
import sys

ALL_PIDS_CMD = "ps --no-headers -e | awk '{ print $1 }'"

# Maximum order the script creates histograms up to. This is by default 9
# since the usual hugepage size on x86 is 2MB which is 2**9 4KB pages
MAX_ORDER = 9

PAGE_SIZE = 2**12
BLANK_HIST = [0] * (MAX_ORDER + 1)

class Vma:
  """Represents a virtual memory area.

  Attributes:
    proc: Process object in which this VMA is contained
    start_vaddr: Start virtual address of VMA
    end_vaddr: End virtual address of VMA
    perms: Permission string of VMA as in /proc/<pid>/maps (eg. rw-p)
    mapped_file: Path to file backing this VMA from /proc/<pid>/maps, empty
      string if not file backed. Note there are some cases in Linux where this
      may be nonempty and the VMA not file backed (eg. memfds)
    hist: This VMA's histogram as a list of integers
  """

  def __init__(self, proc, start_vaddr, end_vaddr, perms, mapped_file):
    self.proc = proc
    self.start_vaddr = start_vaddr
    self.end_vaddr = end_vaddr
    self.perms = perms
    self.mapped_file = mapped_file

  def is_file_backed(self):
    """Returns true if this VMA is file backed, false otherwise."""
    # The output printed for memfds (eg. /memfd:crosvm) also happens to be a
    # valid file path on *nix, so special case them
    return (bool(re.match("(?:/[^/]+)+", self.mapped_file)) and
            not bool(re.match("^/memfd:", self.mapped_file)))

  @staticmethod
  def bitmask(hi, lo):
    """Returns a bitmask with the bits from index hi to low+1 set."""
    return ((1 << (hi - lo)) - 1) << lo

  @property
  @functools.lru_cache(maxsize=50000)
  def hist(self):
    """Returns this VMA's histogram as a list."""
    hist = BLANK_HIST[:]

    pagemap_file = safe_open_procfile(self.proc.pid, "pagemap", "rb")
    if not pagemap_file:
      err_print(
          "Cannot open /proc/{0}/pagemap, not generating histogram".format(
              self.proc.pid))
      return hist

    # Page index of start/end VMA virtual addresses
    vma_start_page_i = self.start_vaddr // PAGE_SIZE
    vma_end_page_i = self.end_vaddr // PAGE_SIZE

    for order in range(0, MAX_ORDER + 1):
      # If there are less than two previous order pages, there can be no more
      # pages of a higher order so just break out to save time
      if order > 0 and hist[order - 1] < 2:
        break

      # First and last pages aligned to 2**order bytes in this VMA
      first_aligned_page = (vma_start_page_i
                            & self.bitmask(64, order)) + 2**order
      last_aligned_page = vma_end_page_i & self.bitmask(64, order)

      # Iterate over all order-sized and order-aligned chunks in this VMA
      for start_page_i in range(first_aligned_page, last_aligned_page,
                                2**order):
        if self._is_region_present(pagemap_file, start_page_i,
                                   start_page_i + 2**order):
          hist[order] += 1

          # Subtract two lower order VMAs so that we don't double-count
          # order n VMAs as two order n-1 VMAs as well
          if order > 0:
            hist[order - 1] -= 2

    pagemap_file.close()
    return hist

  def _is_region_present(self, pagemap_file, start_page_i, end_page_i):
    """Returns True if all pages in the given range are resident.

    Args:
      pagemap_file: Opened /proc/<pid>/pagemap file for this process
      start_page_i: Start page index for range
      end_page_i: End page index for range

    Returns:
      True if all pages from page index start_page_i to end_page_i are present
      according to the pagemap file, False otherwise.
    """
    pagemap_file.seek(start_page_i * 8)
    for _ in range(start_page_i, end_page_i):
      # /proc/<pid>/pagemaps contains an 8 byte value for every page
      page_info, = struct.unpack("Q", pagemap_file.read(8))
      # Bit 63 is set if the page is present
      if not page_info & (1 << 63):
        return False
    return True

  def __str__(self):
    return ("{start:016x}-{end:016x} {size:<8} {perms:<4} {hist:<50} "
            "{mapped_file:<40}").format(
                start=self.start_vaddr,
                end=self.end_vaddr,
                size="%dk" % ((self.end_vaddr - self.start_vaddr) // 1024),
                perms=self.perms,
                hist=str(self.hist),
                mapped_file=str(self.mapped_file))


class Process:
  """Represents a running process.

  Attributes:
    vmas: List of VMA objects representing this processes's VMAs
    pid: Process PID
    name: Name of process (read from /proc/<pid>/status
  """
  _MAPS_LINE_REGEX = ("([0-9a-f]+)-([0-9a-f]+) ([r-][w-][x-][ps-]) "
                      "[0-9a-f]+ [0-9a-f]+:[0-9a-f]+ [0-9]+[ ]*(.*)")

  def __init__(self, pid):
    self.vmas = []
    self.pid = pid
    self.name = None
    self._read_name()
    self._read_vma_info()

  def _read_name(self):
    """Reads this Process's name from /proc/<pid>/status."""
    get_name_sp = subprocess.Popen(
        "grep Name: /proc/%d/status | awk '{ print $2 }'" % self.pid,
        shell=True,
        stdout=subprocess.PIPE)
    self.name = get_name_sp.communicate()[0].decode("ascii").strip()

  def _read_vma_info(self):
    """Populates this Process's VMA list."""
    f = safe_open_procfile(self.pid, "maps", "r")
    if not f:
      err_print("Could not read maps for process {0}".format(self.pid))
      return

    for line in f:
      match = re.match(Process._MAPS_LINE_REGEX, line)
      start_vaddr = int(match.group(1), 16)
      end_vaddr = int(match.group(2), 16)
      perms = match.group(3)
      mapped_file = match.group(4) if match.lastindex == 4 else None
      self.vmas.append(Vma(self, start_vaddr, end_vaddr, perms, mapped_file))
    f.close()

  @property
  @functools.lru_cache(maxsize=50000)
  def hist(self):
    """The process-level memory allocation histogram.

    This is the sum of all VMA histograms for every VMA in this process.
    For example, if a process had two VMAs with the following histograms:

      [1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0]
      [0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0]

    This would return:
      [1, 3, 5, 3, 0, 0, 0, 0, 0, 0, 0]
    """
    return [sum(x) for x in zip(*[vma.hist for vma in self.vmas])]

  def __str__(self):
    return "process {pid:<18} {name:<25} {hist:<50}".format(
        pid=self.pid, name=str(self.name), hist=str(self.hist))


def safe_open_procfile(pid, file_name, mode):
  """Safely open the given file under /proc/<pid>.

  This catches a variety of common errors bound to happen when using this
  script (eg. permission denied, process already exited).

  Args:
    pid: Pid of process (used to construct /proc/<pid>/)
    file_name: File directly under /proc/<pid>/ to open
    mode: Mode to pass to open (eg. "w", "r")

  Returns:
    File object corresponding to file requested or None if there was an error
  """
  full_path = "/proc/{0}/{1}".format(pid, file_name)
  try:
    return open(full_path, mode)
  except PermissionError:
    err_print("Not accessing {0} (permission denied)".format(full_path))
  except FileNotFoundError:
    err_print(
        "Not opening {0} (does not exist, process {1} likely exited)".format(
            full_path, pid))


def err_print(*args, **kwargs):
  print(*args, file=sys.stderr, **kwargs)


def print_hists(args):
  """Prints all process and VMA histograms as/per module documentation."""
  pid_list_sp = subprocess.Popen(
      ALL_PIDS_CMD, shell=True, stdout=subprocess.PIPE)
  pid_list = map(int, pid_list_sp.communicate()[0].splitlines())
  procs = []

  for pid in pid_list:
    procs.append(Process(pid))

  for proc in sorted(procs, key=lambda p: p.hist[::-1]):
    # Don't print info on kernel threads or processes we couldn't collect info
    # on due to insufficent permissions
    if not proc.vmas:
      continue
    print(proc)
    for vma in sorted(proc.vmas, key=lambda v: v.hist[::-1]):
      if args.no_unfaulted_vmas and vma.hist == BLANK_HIST:
        continue
      elif args.omit_file_backed and vma.is_file_backed():
        continue
      print("    ", vma)


if __name__ == "__main__":
  parser = argparse.ArgumentParser(
      description=("Create per-process and per-VMA "
                   "histograms of contigous virtual "
                   "memory allocations"))
  parser.add_argument(
      "--omit-unfaulted-vmas",
      dest="no_unfaulted_vmas",
      action="store_true",
      help="Omit VMAs containing 0 present pages from output")
  parser.add_argument(
      "--omit-file-backed",
      dest="omit_file_backed",
      action="store_true",
      help="Omit VMAs corresponding to mmaped files")
  print_hists(parser.parse_args())
